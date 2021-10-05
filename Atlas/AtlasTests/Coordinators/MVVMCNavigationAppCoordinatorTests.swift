import Quick
import Nimble
@testable import Atlas
import UIKit

class MVVMCNavigationAppCoordinatorTests: QuickSpec {
    override func spec() {
        describe("The MVVMCNavigationAppCoordinator") {
            var sut: MVVMCNavigationAppCoordinator?
            var window: UIWindow?
            
            context("initialized with a factory") {
                var testFactory1: MVVMCFactoryProtocol!
                
                context("calling start()") {
                    beforeEach {
                        window = UIWindow()
                        testFactory1 = GreenFactory()
                        sut = MVVMCNavigationAppCoordinator(model: ModelMock(), window: window!, factory: testFactory1)
                        sut!.start()
                    }
                    
                    afterEach {
                        sut = nil
                        window = nil
                    }
                    
                    it("starts the GreenFactory") {
                        expect((window!.rootViewController as? UINavigationController)?.topViewController).to(beAnInstanceOf(GreenTestViewController.self))
                    }
                    
                    it("has one viewController on the navigation stack") {
                        expect((window!.rootViewController as? UINavigationController)?.viewControllers.count).to(equal(1))
                    }
                }
            }
        }
    }
}
