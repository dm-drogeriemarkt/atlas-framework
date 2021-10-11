import Quick
import Nimble

@testable import Atlas

class MVVMCCoordinatorTests: QuickSpec {
    override func spec() {
        describe("The MVVMCCoordinator") {
            context("after calling start()") {
                context("being in default state") {
                    var model: ModelMock?
                    var sut: MVVMCCoordinator?
                    var navigation: UINavigationController?

                    beforeEach {
                        let factory = StateFactory()
                        navigation = UINavigationController()
                        model = ModelMock()
                        sut = MVVMCCoordinator(model: model!, navigationController: navigation!, factory: factory)
                        sut!.start()
                    }

                    afterEach {
                        sut = nil
                        model = nil
                        navigation = nil
                    }

                    it("displays the red test view") {
                        expect(navigation!.topViewController).to(beAnInstanceOf(RedTestViewController.self))
                    }

                    context("when the logged in state changes") {
                        beforeEach {
                            model!.isLoggedIn = true
                        }

                        context("calling reload()") {
                            beforeEach {
                                sut!.reload()
                            }

                            it("shows the new view") {
                                expect(navigation!.topViewController).to(beAnInstanceOf(BlueTestViewController.self))
                            }

                            it("still has one view only within the hierarchy") {
                                expect(navigation!.viewControllers.count).to(equal(1))
                            }
                        }
                    }
                }
            }
            
            context("calling requestUpdate()") {
                var model: ModelMock?
                var sut: MVVMCCoordinator?
                var navigation: UINavigationController?
                var factory: MVVMCFactoryMock?
                
                beforeEach {
                    factory = MVVMCFactoryMock(transitionType: .push(animated: false))
                    navigation = UINavigationController()
                    model = ModelMock()
                    sut = MVVMCCoordinator(model: model!, navigationController: navigation!, factory: factory!)
                    sut!.start()
                    sut!.requestUpdate(withData: nil)
                }
                
                afterEach {
                    sut = nil
                    model = nil
                    navigation = nil
                }
                
                it("calls update in the current factory") {
                    expect(factory!.didCallUpdate).to(beTrue())
                }
            }


            context("with a factory that is used multiple times") {
                var model: ModelMock?
                var sut: MVVMCCoordinator?
                var navigation: NavigationControllerMock?

                beforeEach {
                    navigation = NavigationControllerMock()
                    model = ModelMock()
                }

                afterEach {
                    model = nil
                    navigation = nil
                }

                context("having an animated modal transition") {
                    beforeEach {
                        let factory = MVVMCFactoryMock(transitionType: .modal(animated: true))
                        sut = MVVMCCoordinator(model: model!, navigationController: navigation!, factory: factory)
                    }

                    afterEach {
                        sut = nil
                    }

                    context("calling start") {
                        beforeEach {
                            sut!.start()
                        }

                        it("calls present on the navigationController with animation") {
                            expect(navigation!.transitions.count).to(equal(1))
                            expect(navigation!.transitions.last).to(equal(.modal(animated: true)))
                        }

                        context("calling reload") {
                            beforeEach {
                                sut!.reload()
                            }

                            it("calls dismiss on the navigationController without animation") {
                                expect(navigation!.dismissCalls.count).to(equal(1))
                                expect(navigation!.dismissCalls.last).to(beFalse())
                            }

                            it("calls present on the navigationController without animation") {
                                expect(navigation!.transitions.count).to(equal(2))
                                expect(navigation!.transitions.last).to(equal(.modal(animated: false)))
                            }
                        }
                    }
                }

                context("having an animated push transition") {
                    beforeEach {
                        let factory = MVVMCFactoryMock(transitionType: .push(animated: true))
                        sut = MVVMCCoordinator(model: model!, navigationController: navigation!, factory: factory)
                    }

                    afterEach {
                        sut = nil
                    }

                    context("calling start") {
                        beforeEach {
                            sut!.start()
                        }

                        it("calls present on the navigationController with animation") {
                            expect(navigation!.transitions.count).to(equal(1))
                            expect(navigation!.transitions.last).to(equal(.push(animated: true)))
                        }

                        context("calling reload") {
                            beforeEach {
                                sut!.reload()
                            }

                            it("calls dismiss on the navigationController without animation") {
                                expect(navigation!.popCalls.count).to(equal(0))
                                expect(navigation!.popCalls.last).to(beNil())
                                expect(navigation!.viewControllers.count).to(equal(1))
                            }

                            it("calls present on the navigationController without animation") {
                                expect(navigation!.transitions.count).to(equal(2))
                                expect(navigation!.transitions.last).to(equal(.push(animated: false)))
                            }
                        }
                    }
                }
            }

            context("with stateFactory") {
                context("after calling start()") {
                    var sut: MVVMCCoordinator?
                    var navController: UINavigationController?
                    let factory = StateFactory()
                    
                    beforeEach {
                        navController = UINavigationController()
                        
                        let model = ModelMock()
                        
                        sut = MVVMCCoordinator(model: model, navigationController: navController!, factory: factory)
                        sut?.start()
                    }
                    
                    afterEach {
                        sut = nil
                        navController = nil
                    }
                    
                    context("requesting dismissal") {
                        it("request its coordinatorDelegate to dismiss") {
                            let mock = MVVMCCoordinatorMock()
                            sut!.coordinatorDelegate = mock
                            sut!.request(navigation: MVVMCNavigationRequest.dismiss, withData: nil)
                            expect(mock.didCallCoordinatorRequestsDismissal).to(beTrue())
                        }
                    }
                }
            }
            
            context("with stateFactory") {
                context("after calling start()") {                    
                    context("calling viewModel requestTransition") {
                        it("displays the green test view") {
                            let model = ModelMock()
                            let factory = StateFactory()
                            
                            let navigation = UINavigationController()
                            
                            let sut = MVVMCCoordinator(model: model, navigationController: navigation, factory: factory)
                            
                            sut.start()
                            
                            sut.request(navigation: MVVMCNavigationRequest.request(target: TestTargets.green), withData: nil)
                            
                            expect(navigation.topViewController).to(beAnInstanceOf(GreenTestViewController.self))
                        }

                        //commented out due to Window requesting client id
                        xit("displays the blue test view") {
                            let model = ModelMock()
                            let factory = BlueFactory()
                            
                            let navigation = UINavigationController()
                            
                            let sut = MVVMCCoordinator(model: model, navigationController: navigation, factory: factory)
                            
                            let window = UIWindow(frame: UIScreen.main.bounds)
                            window.makeKey()
                            window.rootViewController = navigation

                            sut.start()
                            
                            sut.request(navigation: MVVMCNavigationRequest.request(target: TestTargets.blue), withData: nil)
                            
                            expect(navigation.presentedViewController).to(beAnInstanceOf(BlueTestViewController.self))
                        }

                        it("sets itself as coordinatorDelegate") {
                            let model = ModelMock()
                            let factory = StateFactory()
                            
                            let navigation = UINavigationController()
                            
                            let sut = MVVMCCoordinator(model: model, navigationController: navigation, factory: factory)
                            
                            sut.start()
                            
                            sut.request(navigation: MVVMCNavigationRequest.request(target: TestTargets.green), withData: nil)
                            
                            expect(sut.targetCoordinator?.coordinatorDelegate).to(be(sut))
                        }
                        
                        it("dismisses the green test view") {
                            let model = ModelMock()
                            let factory = StateFactory()
                            
                            let navigation = UINavigationController()

                            let sut = MVVMCCoordinator(model: model, navigationController: navigation, factory: factory)
                            
                            sut.start()
                            
                            sut.request(navigation: MVVMCNavigationRequest.request(target: TestTargets.green), withData: nil)
                            
                            sut.childCoordinatorRequestsDismissal(sut.targetCoordinator!, transitionType: factory.transitionType, animated: false)
                            
                            expect(navigation.presentedViewController).toEventually(beNil(), timeout: .seconds(2))
                            expect(navigation.topViewController).toEventually(beAnInstanceOf(RedTestViewController.self))
                        }
                    }
                }
            }
        }
    }
}
