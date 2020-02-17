import UIKit
import Atlas

class MVVMCFactoryMock: MVVMCFactoryProtocol {
    var transitionType: MVVMCTransitionType
    var createViewCallCount = 0
    var didCallUpdate = false

    init(transitionType: MVVMCTransitionType) {
        self.transitionType = transitionType
    }

    func target(forIdentifier: MVVMCNavigationTarget) -> MVVMCFactoryProtocol? {
        return nil
    }

    func createView(model: MVVMCModelProtocol, delegate: MVVMCViewDelegate) -> UIViewController {
        createViewCallCount += 1
        return UIViewController()
    }
    
    func update(withData data: [String : Any]?) {
        didCallUpdate = true
    }
}
