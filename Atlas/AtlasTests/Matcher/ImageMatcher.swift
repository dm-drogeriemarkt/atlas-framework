import Nimble
import UIKit
import Foundation

public func equalImage(expectedValue: UIImage?) -> Predicate<UIImage?> {
    return Predicate { actualExpression in
        let failureMessage = ExpectationMessage.expectedActualValueTo("equal <\(expectedValue as UIImage?)>")
        
        if let actualValue = try actualExpression.evaluate() {
            guard let actualValue = actualValue, let expectedValue = expectedValue else {
                return PredicateResult(bool: false, message: failureMessage)
            }
            
            if let expectedData = UIImagePNGRepresentation(expectedValue), let actualData = UIImagePNGRepresentation(actualValue) {
                return PredicateResult(bool: actualData == expectedData, message: failureMessage)
            }
        }

        return PredicateResult(bool: false, message: failureMessage)
    }
}
