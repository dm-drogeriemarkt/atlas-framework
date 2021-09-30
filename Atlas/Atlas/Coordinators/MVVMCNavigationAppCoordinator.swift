import UIKit

public class MVVMCNavigationAppCoordinator: NSObject, MVVMCAppCoordinator {
    let model: MVVMCModelProtocol
    let window: UIWindow
    var rootViewController: UIViewController?
    var modules: [MVVMCModule]

    private var isStarted = false
    private var deferredDeepLink: (chain: [MVVMCNavigationRequest], tab: Int?, completion: (() -> Void)?)?
    
    required public init(model: MVVMCModelProtocol, window: UIWindow, factory: MVVMCFactoryProtocol) {
        self.model = model
        self.window = window
        self.modules = []
        
        super.init()
        setupModule(for: factory)
    }

    public func start() {
        window.rootViewController = rootViewController
        // TODO: Do not start all modules directly at the beginning
        for module in modules {
            module.coordinator.start()
        }

        isStarted = true

        if let deferredDeepLink = deferredDeepLink {
            self.deepLink(chain: deferredDeepLink.chain, selectedTab: deferredDeepLink.tab, completion: deferredDeepLink.completion)
        }
    }
    
    func setupModule(for factory: MVVMCFactoryProtocol) {
        let navigationController = setupNavigationController(prefersLargeTitles: factory.prefersLargeTitles)
        let coordinator = MVVMCCoordinator(model: model, navigationController: navigationController, factory: factory)
        let module = MVVMCModule(factory: factory, navigationController: navigationController, coordinator: coordinator)
        self.rootViewController = navigationController
        modules.append(module)
    }

    func setupNavigationController(prefersLargeTitles: Bool = true) -> UINavigationController {
        let navController = UINavigationController()
        navController.navigationBar.isTranslucent = false
        if #available(iOS 11.0, *) {
            navController.navigationBar.prefersLargeTitles = prefersLargeTitles
        }

        navController.view.backgroundColor = UIColor.white
        return navController
    }
    
    public func deepLink(chain: [MVVMCNavigationRequest], selectedTab: Int?, completion: (() -> Void)?) {
        guard isStarted else {
            deferredDeepLink = (chain, selectedTab, completion)
            return
        }
        
        guard let module = modules.first else { return }
        module.navigationController.dismiss(animated: false, completion: nil)
        module.navigationController.popToRootViewController(animated: false)
        var coordinator: MVVMCCoordinatorProtocol? = module.coordinator

        for request in chain {
            coordinator?.request(navigation: request, withData: [:], animated: false)
            coordinator = coordinator?.targetCoordinator
        }
        completion?()
    }
}
