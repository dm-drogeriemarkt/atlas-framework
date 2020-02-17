import UIKit

public protocol MVVMCFactoryProtocol {
    var transitionType: MVVMCTransitionType { get }
    func target(forIdentifier: MVVMCNavigationTarget) -> MVVMCFactoryProtocol?
    func createView(model: MVVMCModelProtocol, delegate: MVVMCViewDelegate) -> UIViewController
    func update(withData data: [String : Any]?)
}

public extension MVVMCFactoryProtocol {
    func update(withData data: [String : Any]?) {
    }
}
