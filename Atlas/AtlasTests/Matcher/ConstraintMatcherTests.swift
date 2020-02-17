import Quick
import Nimble

func createTestingConstraint(superview: UIView, subview: UIView, edge: NSLayoutAttribute, inset: CGFloat) -> NSLayoutConstraint {
    return NSLayoutConstraint(item: subview, attribute: edge, relatedBy: .equal, toItem: superview, attribute: edge, multiplier: 1.0, constant: inset)
}

class ConstraintMatcherTests: QuickSpec {
    override func spec() {
        describe("The ConstraintMatcher") {
            context("comparing similar constraints") {
                var superview: UIView?
                var subview: UIView?
                var constraint1: NSLayoutConstraint?
                var constraint2: NSLayoutConstraint?
                
                beforeEach {
                    superview = UIView()
                    subview = UIView()
                    subview!.translatesAutoresizingMaskIntoConstraints = false
                    superview!.addSubview(subview!)
                    
                    constraint1 = createTestingConstraint(superview: superview!, subview: subview!, edge: .bottom, inset: 1)
                    constraint2 = createTestingConstraint(superview: superview!, subview: subview!, edge: .bottom, inset: 1)
                }
                
                afterEach {
                    superview = nil
                    subview = nil
                    constraint1 = nil
                    constraint2 = nil
                }
                
                it("returns true on item1") {
                    expect([constraint1!]).to(hasConstraint(expectedValue: constraint2!))
                }
                
                it("returns true on item2") {
                    expect([constraint1!]).to(hasConstraint(expectedValue: constraint2!))
                }
                
                it("returns true on attribute1") {
                    expect([constraint1!]).to(hasConstraint(expectedValue: constraint2!))
                }
                
                it("returns true on attribute2") {
                    expect([constraint1!]).to(hasConstraint(expectedValue: constraint2!))
                }
                
                it("returns true on constant") {
                    expect([constraint1!]).to(hasConstraint(expectedValue: constraint2!))
                }
                
                it("returns true on multiplier") {
                    expect([constraint1!]).to(hasConstraint(expectedValue: constraint2!))
                }
                
                it("returns true on relation") {
                    expect([constraint1!]).to(hasConstraint(expectedValue: constraint2!))
                }
            }
            
            context("comparing different constraints") {
                var superview: UIView?
                var subview: UIView?
                var constraint1: NSLayoutConstraint?
                
                beforeEach {
                    superview = UIView()
                    subview = UIView()
                    subview!.translatesAutoresizingMaskIntoConstraints = false
                    superview!.addSubview(subview!)
                    
                    constraint1 = createTestingConstraint(superview: superview!, subview: subview!, edge: .bottom, inset: 1)
                }
                
                afterEach {
                    superview = nil
                    subview = nil
                    constraint1 = nil
                }
                
                it("returns false on item1") {
                    let superview2 = UIView()
                    let constraint2 = createTestingConstraint(superview: superview2, subview: subview!, edge: .bottom, inset: 1)
                    
                    expect([constraint1!]).notTo(hasConstraint(expectedValue: constraint2))
                }
                
                it("returns false on item2") {
                    let subview2 = UIView()
                    let constraint2 = createTestingConstraint(superview: superview!, subview: subview2, edge: .bottom, inset: 1)
                    
                    expect([constraint1!]).notTo(hasConstraint(expectedValue: constraint2))
                }
                
                it("returns false on attribute1") {
                    let constraint2 = createTestingConstraint(superview: superview!, subview: subview!, edge: .top, inset: 1)
                    expect([constraint1!]).notTo(hasConstraint(expectedValue: constraint2))
                }
                
                it("returns false on attribute2") {
                    let constraint2 = NSLayoutConstraint(item: subview!, attribute: .bottom, relatedBy: .equal, toItem: superview!, attribute: .top, multiplier: 1.0, constant: 1.0)
                    expect([constraint1!]).notTo(hasConstraint(expectedValue: constraint2))
                }
                
                it("returns false on constant") {
                    let constraint2 = NSLayoutConstraint(item: subview!, attribute: .bottom, relatedBy: .equal, toItem: superview!, attribute: .bottom, multiplier: 1.0, constant: 2.0)
                    expect([constraint1!]).notTo(hasConstraint(expectedValue: constraint2))
                }
                
                it("returns false on multiplier") {
                    let constraint2 = NSLayoutConstraint(item: subview!, attribute: .bottom, relatedBy: .equal, toItem: superview!, attribute: .bottom, multiplier: 2.0, constant: 1.0)
                    expect([constraint1!]).notTo(hasConstraint(expectedValue: constraint2))
                }
                
                it("returns false on relation") {
                    let constraint2 = NSLayoutConstraint(item: subview!, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: superview!, attribute: .bottom, multiplier: 1.0, constant: 1.0)
                    expect([constraint1!]).notTo(hasConstraint(expectedValue: constraint2))
                }
                
                it("returns false on nil") {
                    let constraint2 = NSLayoutConstraint(item: subview!, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: superview!, attribute: .bottom, multiplier: 1.0, constant: 1.0)
                    expect(nil).notTo(hasConstraint(expectedValue: constraint2))
                }
            }
        }
    }
}
