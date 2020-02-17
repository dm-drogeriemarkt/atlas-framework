import Quick
import Nimble
import Atlas

class MVVMCTabBarFactoryTests: QuickSpec {
    override func spec() {
        describe("A MVVMCTabBarFactory") {
            context("having no tabBarTitle specified") {
                it("returns nil as default value") {
                    let sut = MVVMCTabBarFactoryWithoutTitle()
                    expect(sut.tabBarTitle).to(beNil())
                }
            }

            context("having a tabBarTitle specified") {
                it("returns the specified tabBarTitle") {
                    let sut = MVVMCTabBarFactoryWithTitle()
                    expect(sut.tabBarTitle).to(equal("TabBarTitle"))
                }
            }
        }
    }
}
