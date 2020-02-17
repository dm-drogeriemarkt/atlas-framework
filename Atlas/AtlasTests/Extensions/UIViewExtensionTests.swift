import Quick
import Nimble

@testable import Atlas

class UIViewExtensionTests: QuickSpec {
    override func spec() {
        describe("The UIView with Autolayout") {
            var sut: UIView?
            
            context("when pinning to superview edges") {
                beforeEach {
                    sut = UIView()
                    sut?.translatesAutoresizingMaskIntoConstraints = false
                }
                
                afterEach {
                    sut = nil
                }
                
                it("constrains both width and height") {
                    let superview = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
                    sut?.pinEdgesTo(superview: superview)
                    
                    expect(superview.constraints).to(hasConstraint(expectedValue:createTestingConstraint(superview: superview, subview: sut!, edge: .top, inset: 0.0)))
                    expect(superview.constraints).to(hasConstraint(expectedValue:createTestingConstraint(superview: superview, subview: sut!, edge: .left, inset: 0.0)))
                    expect(superview.constraints).to(hasConstraint(expectedValue:createTestingConstraint(superview: superview, subview: sut!, edge: .bottom, inset: 0.0)))
                    expect(superview.constraints).to(hasConstraint(expectedValue:createTestingConstraint(superview: superview, subview: sut!, edge: .right, inset: 0.0)))
                    expect(superview.constraints.count).to(equal(4))
                }
            }
        }
                
        describe("The UIView with ViewContainer") {
            var sut: UIView?
            
            context("after initialization") {
                beforeEach {
                    sut = UIView()
                }
                
                afterEach {
                    sut = nil
                }

                it("has no subviews") {
                    expect(sut!.subviews.count).to(equal(0))
                }
                
                it("has no constraints") {
                    expect(sut!.constraints.count).to(equal(0))
                }
            }
            
            context("after adding a view to containerView") {
                let containedView: Pinable = UIView()
                
                beforeEach {
                    sut = UIView()
                    sut!.addToContainer(view: containedView)
                }
                
                afterEach {
                    sut = nil
                }

                it("has one subview") {
                    expect(sut!.subviews.count).to(equal(1))
                }
                
                it("contains the added view") {
                    expect(sut!.subviews.first).to(beIdenticalTo(containedView))
                }
                
                it("has 4 constraints because of pinEdgesTo") {
                    expect(sut!.constraints.count).to(equal(4))
                }
            }
            
            context("after clearing a containerView that previously contained a view") {
                let containedView: Pinable = UIView()
                
                beforeEach {
                    sut = UIView()
                    sut!.addToContainer(view: containedView)
                    sut!.clearContainer()
                }
                
                afterEach {
                    sut = nil
                }
                
                it("has no subviews") {
                    expect(sut!.subviews.count).to(equal(0))
                }
                
                it("has no constrains") {
                    expect(sut!.constraints.count).to(equal(0))
                }
            }
        }
    }
}
