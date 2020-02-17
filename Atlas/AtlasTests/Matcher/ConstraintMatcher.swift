import Nimble
import UIKit

public func hasConstraint(expectedValue: NSLayoutConstraint) -> Predicate<[NSLayoutConstraint]?> {
    return Predicate { actualExpression in
        let failureMessage = ExpectationMessage.expectedActualValueTo("equal <\(expectedValue as NSLayoutConstraint?)>")
        
        if let actualValue = try actualExpression.evaluate() {
            return PredicateResult(
                bool: containsConstraint(constraints: actualValue!, targetConstraint: expectedValue),
                message: failureMessage
            )
        }
        
        return PredicateResult(bool: false, message: failureMessage)
    }
}


func containsConstraint(constraints: [NSLayoutConstraint], targetConstraint: NSLayoutConstraint) -> Bool {
    for constraint in constraints {
        let targetFirstItem = targetConstraint.firstItem as? UIView
        let constraintFirstItem = constraint.firstItem as? UIView
        let targetSecondItem = targetConstraint.secondItem as? UIView
        let constraintSecondItem = constraint.secondItem as? UIView
        
        let firstAttributeMatches = targetConstraint.firstAttribute == constraint.firstAttribute
        let firstItemMatches = targetFirstItem == constraintFirstItem
        let secondAttributeMatches = targetConstraint.secondAttribute == constraint.secondAttribute
        let secondItemMatches = targetSecondItem == constraintSecondItem
        let constantMatches = targetConstraint.constant == constraint.constant
        let multiplierMatches = targetConstraint.multiplier == constraint.multiplier
        let relationMatches = targetConstraint.relation == constraint.relation
        
        let matchFound = firstAttributeMatches
                            && firstItemMatches
                            && secondAttributeMatches
                            && secondItemMatches
                            && constantMatches
                            && multiplierMatches
                            && relationMatches
        
        if matchFound {
            return true
        }
    }
    
    return false
}
