import UIKit
@testable import Atlas

class MVVMCCoordinatorMock: MVVMCCoordinatorProtocol {
    var targetCoordinator: MVVMCCoordinatorProtocol?
    var coordinatorDelegate: MVVMCChildCoordinatorDelegate?
    var didCallCoordinatorRequestsDismissal = false
    var didCallViewModelRequestsWithData = false
    var didRequestDismissal = false
    
    func start(skipAnimation: Bool = false) {
    }

    func reload() {
    }

    func requestUpdate(withData data: [String : Any]?) {
    }

    func startWithViewController() {
    }
    
    func request(navigation request: MVVMCNavigationRequest, withData data: [String : Any]?) {
        didCallViewModelRequestsWithData = true
        if case .dismiss = request {
            didRequestDismissal = true
        }
    }

    func request(navigation request: MVVMCNavigationRequest, withData data: [String : Any]?, animated: Bool) {
        didCallViewModelRequestsWithData = true
        if case .dismiss = request {
            didRequestDismissal = true
        }
    }
    
    func childCoordinatorRequestsDismissal(_ coordinator: MVVMCCoordinatorProtocol, transitionType: MVVMCTransitionType, animated: Bool) {
        didCallCoordinatorRequestsDismissal = true
    }
}
