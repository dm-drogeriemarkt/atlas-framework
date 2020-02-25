import UIKit

class MVVMCCoordinator {
    var model: MVVMCModelProtocol
    var factory: MVVMCFactoryProtocol
    var navigationController: UINavigationController
    var targetCoordinator: MVVMCCoordinatorProtocol?
    weak var coordinatorDelegate: MVVMCChildCoordinatorDelegate?

    required init(model: MVVMCModelProtocol, navigationController: UINavigationController, factory: MVVMCFactoryProtocol) {
        self.model = model
        self.navigationController = navigationController
        self.factory = factory
    }
}

// MARK: - CoordinatorProtocol
extension MVVMCCoordinator: MVVMCCoordinatorProtocol {
    func start(skipAnimation: Bool = false) {
        let view = factory.createView(model: model, delegate: self)
        display(view: view, withTransitionType: factory.transitionType, skipAnimation: skipAnimation)
    }
    
    func requestUpdate(withData data: [String : Any]?) {
        factory.update(withData: data)
    }

    func reload() {
        dismissCurrentView(factory.transitionType, skipAnimation: true)
        start(skipAnimation: true)
    }
}

// MARK: - transitions
extension MVVMCCoordinator {
    private func display(view: UIViewController, withTransitionType transitionType: MVVMCTransitionType, skipAnimation: Bool) {
        switch transitionType {
            case .modal(let animated):
                navigationController.present(view, animated: skipAnimation ? false : animated)
            case .push(let animated):
                navigationController.pushViewController(view, animated: skipAnimation ? false : animated)
        }
    }
}

// MARK: - MVVMCViewModelDelegate
extension MVVMCCoordinator {
    func request(navigation request: MVVMCNavigationRequest, withData data: [String : Any]?) {
        self.request(navigation: request, withData: data, animated: true)
    }
    
    func request(navigation request: MVVMCNavigationRequest, withData data: [String : Any]?, animated: Bool) {
        switch request {
            case .dismiss: coordinatorDelegate?.childCoordinatorRequestsDismissal(self, transitionType: factory.transitionType, animated: true)
            case .request(let target): navigateTo(target, animated: animated)
        }
    }
    
    func navigateTo(_ target: MVVMCNavigationTarget, animated: Bool) {
        guard let targetFactory = factory.target(forIdentifier: target) else {
            return
        }

        targetCoordinator = MVVMCCoordinator(model: model, navigationController: navigationController, factory: targetFactory)
        targetCoordinator?.coordinatorDelegate = self
        targetCoordinator?.start(skipAnimation: !animated)
    }
}

// MARK: - MVVMCChildCoordinatorDelegate
extension MVVMCCoordinator {
    func childCoordinatorRequestsDismissal(_ coordinator: MVVMCCoordinatorProtocol, transitionType: MVVMCTransitionType, animated: Bool) {
        dismissCurrentView(transitionType)
        targetCoordinator = nil
    }
}

// MARK: - Handling the view controllers
extension MVVMCCoordinator {
    private func dismissCurrentView(_ transitionType: MVVMCTransitionType, skipAnimation: Bool = false) {
        switch transitionType {
            case .push(let animated):
                if (navigationController.viewControllers.count > 1) {
                    navigationController.popViewController(animated: skipAnimation ? false : animated)
                } else {
                    navigationController.viewControllers = []
                }
            case .modal(let animated): navigationController.dismiss(animated: skipAnimation ? false : animated, completion: nil)
        }
    }
}
