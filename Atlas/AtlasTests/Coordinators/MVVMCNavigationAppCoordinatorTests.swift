import Quick
import Nimble

@testable import Atlas

class MVVMCNavigationAppCoordinatorTests: QuickSpec {
    override func spec() {
        describe("The MVVMCNavigationAppCoordinator") {
            var sut: MVVMCNavigationAppCoordinator?
            var window: UIWindow?
            var rootViewController: UITabBarController?
            
            context("initialized with 2 factories") {
                var testFactory1: MVVMCTabBarFactoryProtocol!
                var testFactory2: MVVMCTabBarFactoryProtocol!
                
                context("calling start()") {
                    beforeEach {
                        window = UIWindow()
                        testFactory1 = Feature1Factory()
                        testFactory2 = Feature2Factory()
                        sut = MVVMCNavigationAppCoordinator(model: ModelMock(), window: window!, factory: testFactory1)
                        sut!.start()
                    }
                    
                    afterEach {
                        sut = nil
                        window = nil
                        rootViewController = nil
                    }
                    
                    context("on the first tab") {
                        var topMostViewController: UIViewController?
                        
                        beforeEach {
                            rootViewController = window!.rootViewController as? UITabBarController
                            topMostViewController = (rootViewController?.selectedViewController as! UINavigationController).topViewController
                        }
                        
                        afterEach {
                            rootViewController = nil
                            topMostViewController = nil
                        }
                        
                        it("has a navigationBar") {
                            expect(topMostViewController?.navigationController).notTo(beNil())
                        }
                        
                        it("has a tabBar") {
                            expect(topMostViewController?.tabBarController).notTo(beNil())
                        }
                        
                        it("has a title") {
                            expect(topMostViewController?.navigationController?.tabBarItem.title).to(equal(testFactory1.tabBarItemTitle))
                        }
                        
                        it("creates a tabBar with 2 elements") {
                            expect(rootViewController?.tabBar.items?.count).to(equal(2))
                        }
                        
                        it("sets the selected image for the first icon") {
                            expect(rootViewController?.tabBar.items?[0].selectedImage).to(equalImage(expectedValue: UIImage.loadTestImage(named: "CircleSelected")))
                        }
                        
                        it("sets the unselected image for the first icon") {
                            expect(rootViewController?.tabBar.items?[0].image).to(equalImage(expectedValue: UIImage.loadTestImage(named: "CircleUnselected")))
                        }
                        
                        it("starts the Feature1Coordinator") {
                            expect(topMostViewController).to(beAnInstanceOf(GreenTestViewController.self))
                        }
                    }
                    
                    context("tapping the already active first Tab") {
                        var navigationController: UINavigationController?

                        beforeEach {
                            sut!.tabBar.delegate?.tabBarController!((sut?.tabBar)!, didSelect: (sut?.modules[0].navigationController)!)
                            sut!.tabBar.selectedIndex = 0

                            navigationController = (window!.rootViewController as? UITabBarController)!.selectedViewController as? UINavigationController
                        }
                        
                        afterEach {
                            navigationController = nil
                        }

                        it("has one viewController on the navigation stack") {
                            expect(navigationController?.viewControllers.count).to(equal(1))
                        }
                    }
                    
                    context("switching to second Tab") {
                        var currentNavigationController: UINavigationController?
                        
                        beforeEach {
                        sut!.tabBar.delegate?.tabBarController!((sut?.tabBar)!, didSelect: (sut?.modules[1].navigationController)!)
                            sut!.tabBar.selectedIndex = 1
                            
                            rootViewController = window!.rootViewController as? UITabBarController
                            
                            currentNavigationController = rootViewController?.selectedViewController as! UINavigationController
                        }
                        
                        afterEach {
                            rootViewController = nil
                        }
                        
                        it("starts a PushCoordinator") {
                            expect((rootViewController?.selectedViewController as! UINavigationController).topViewController).to(beAnInstanceOf(BlueTestViewController.self))
                        }
                        
                        it("has a title") {
                            expect(currentNavigationController?.tabBarItem.title).to(equal(testFactory2.tabBarItemTitle))
                        }

                        it("keeps the other view") {
                            let viewController = sut?.modules[0].navigationController.topViewController
                            expect(viewController).notTo(beNil())
                        }
                        
                        context("switching to first tab") {
                            it("displays the MVVMCContainer") {
                                sut?.tabBar.delegate?.tabBarController!((sut?.tabBar)!, didSelect: (sut?.modules[0].navigationController)!)
                                sut?.tabBar.selectedIndex = 0
                                let viewController = sut?.modules[0].navigationController.topViewController
                                expect(viewController).to(beAnInstanceOf(GreenTestViewController.self))
                            }

                            it("keeps the other view") {
                                sut?.tabBar.delegate?.tabBarController!((sut?.tabBar)!, didSelect: (sut?.modules[0].navigationController)!)
                                sut?.tabBar.selectedIndex = 0
                                
                                let viewController = sut?.modules[1].navigationController.topViewController
                                expect(viewController).notTo(beNil())
                            }
                        }
                    }

                    // TODO: This test can be repaired as soon as coordinators are started lazily
                    xcontext("passing not a UINavigationViewController") {
                        beforeEach {
                            sut!.tabBar.delegate?.tabBarController!((sut?.tabBar)!, didSelect: UIViewController())
                            sut!.tabBar.selectedIndex = 1
                            
                            rootViewController = window!.rootViewController as? UITabBarController
                        }
                        
                        afterEach {
                            rootViewController = nil
                        }
                        
                        it("does not start the Coordinator") {
                            expect((rootViewController?.selectedViewController as! UINavigationController).topViewController).to(beNil())
                        }
                    }
                }
            }

            context("initialized with 3 factories") {
                context("calling start") {
                    context("calling start()") {
                        beforeEach {
                            window = UIWindow()
                            
                            sut = MVVMCNavigationAppCoordinator(model: ModelMock(), window: window!, factory: Feature1Factory())
                            sut!.start()
                            
                            rootViewController = window!.rootViewController as? UITabBarController
                        }
                        
                        afterEach {
                            sut = nil
                            rootViewController = nil
                        }
                        
                        it("creates a tabBar with 3 elements") {
                            expect((window!.rootViewController as! UITabBarController).tabBar.items?.count).to(equal(3))
                        }
                    }
                }
            }
        }
    }
}
