import UIKit

extension UIImage {
    static func loadTestImage(named: String) -> UIImage? {
        let bundle = Bundle(for: ImageMatcherTests.self)
        return UIImage(named: named, in: bundle, compatibleWith: nil)
    }
}
