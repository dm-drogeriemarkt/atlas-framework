import UIKit
import Atlas

class NavigationControllerMock: UINavigationController {
    var transitions: [MVVMCTransitionType] = []
    var dismissCalls: [Bool] = []
    var popCalls: [Bool] = []

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        transitions.append(.modal(animated: flag))
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismissCalls.append(flag)
        super.dismiss(animated: flag, completion: completion)
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        transitions.append(.push(animated: animated))
        super.pushViewController(viewController, animated: animated)
    }

    override func popViewController(animated: Bool) -> UIViewController? {
        popCalls.append(animated)
        return super.popViewController(animated: animated)
    }
}
