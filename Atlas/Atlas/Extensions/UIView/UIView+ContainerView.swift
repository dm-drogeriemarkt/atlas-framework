import UIKit

// MARK: - implementation
extension UIView {
    public func addToContainer(view: Pinable) {
        view.pinEdgesTo(superview: self)
    }
    
    public func clearContainer() {
        self.subviews.forEach { $0.removeFromSuperview() }
    }
}
