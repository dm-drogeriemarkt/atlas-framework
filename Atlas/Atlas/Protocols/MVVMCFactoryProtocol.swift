import UIKit

public protocol MVVMCFactoryProtocol {
    var transitionType: MVVMCTransitionType { get }
    var prefersLargeTitles: Bool { get }

    func target(forIdentifier: MVVMCNavigationTarget) -> MVVMCFactoryProtocol?
    func createView(model: MVVMCModelProtocol, delegate: MVVMCViewDelegate) -> UIViewController
    func update(withData data: [String : Any]?)
}

public extension MVVMCFactoryProtocol {
    var prefersLargeTitles: Bool { false }
    
    func update(withData data: [String : Any]?) {}
}
