import UIKit

extension UIView: Pinable {
    public func pinEdgesTo(superview: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(self)
        
        superview.addConstraint(NSLayoutConstraint(item: self,
                                                   attribute: .top,
                                                   relatedBy: .equal,
                                                   toItem: superview,
                                                   attribute: .top,
                                                   multiplier: 1.0,
                                                   constant: 0))
        
        superview.addConstraint(NSLayoutConstraint(item: self,
                                                   attribute: .left,
                                                   relatedBy: .equal,
                                                   toItem: superview,
                                                   attribute: .left,
                                                   multiplier: 1.0,
                                                   constant: 0))
        
        superview.addConstraint(NSLayoutConstraint(item: self,
                                                   attribute: .bottom,
                                                   relatedBy: .equal,
                                                   toItem: superview,
                                                   attribute: .bottom,
                                                   multiplier: 1.0,
                                                   constant: 0))
        
        superview.addConstraint(NSLayoutConstraint(item: self,
                                                   attribute: .right,
                                                   relatedBy: .equal,
                                                   toItem: superview,
                                                   attribute: .right,
                                                   multiplier: 1.0,
                                                   constant: 0))
    }
}
