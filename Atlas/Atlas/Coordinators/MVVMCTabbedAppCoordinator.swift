import UIKit

public class MVVMCTabbedAppCoordinator: NSObject, MVVMCAppCoordinator {
    let model: MVVMCModelProtocol
    let window: UIWindow
    let tabBar: UITabBarController
    var modules: [MVVMCModule]

    private var isStarted = false
    private var deferredDeepLink: (chain: [MVVMCNavigationRequest], tab: Int?, completion: (() -> Void)?)?

    required public init(model: MVVMCModelProtocol, window: UIWindow, factories: [MVVMCTabBarFactoryProtocol]) {
        self.model = model
        self.window = window
        self.modules = []

        tabBar = UITabBarController()
        tabBar.viewControllers = []

        super.init()

        tabBar.delegate = self
        setupModules(for: factories)
    }

    public func start() {
        window.rootViewController = tabBar
        // TODO: Do not start all modules directly at the beginning
        for module in modules {
            module.coordinator.start()
        }

        isStarted = true

        if let deferredDeepLink = deferredDeepLink {
            self.deepLink(chain: deferredDeepLink.chain, selectedTab: deferredDeepLink.tab, completion: deferredDeepLink.completion)
        }
    }

    func setupModules(for factories: [MVVMCTabBarFactoryProtocol]) {
        var rootViewControllers: [UINavigationController] = []

        for factory in factories {
            let navigationController = setupTabBarItem(title: factory.tabBarItemTitle, image: factory.unselectedTabBarIconImage, selectedImage: factory.selectedTabBarIconImage, prefersLargeTitles: factory.prefersLargeTitles)
            let coordinator = MVVMCCoordinator(model: model, navigationController: navigationController, factory: factory)
            let module = MVVMCModule(factory: factory, navigationController: navigationController, coordinator: coordinator)

            rootViewControllers.append(navigationController)
            modules.append(module)
        }

        tabBar.setViewControllers(rootViewControllers, animated: false)
        tabBar.tabBar.isTranslucent = false
    }

    func setupTabBarItem(title: String?, image: UIImage?, selectedImage: UIImage?, prefersLargeTitles: Bool = true) -> UINavigationController {
        let navController = UINavigationController()
        navController.navigationBar.isTranslucent = false
        if #available(iOS 11.0, *) {
            navController.navigationBar.prefersLargeTitles = prefersLargeTitles
        }
        navController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)

        navController.view.backgroundColor = UIColor.white
        return navController
    }

    public func deepLink(chain: [MVVMCNavigationRequest], selectedTab: Int?, completion: (() -> Void)?) {
        guard isStarted else {
            deferredDeepLink = (chain, selectedTab, completion)
            return
        }
        guard let selectedTab = selectedTab else { return }
        let module = modules[selectedTab]
        module.navigationController.dismiss(animated: false, completion: nil)
        tabBar.selectedIndex = selectedTab
        module.navigationController.popToRootViewController(animated: false)
        var coordinator: MVVMCCoordinatorProtocol? = module.coordinator

        for request in chain {
            coordinator?.request(navigation: request, withData: [:], animated: false)
            coordinator = coordinator?.targetCoordinator
        }
        completion?()
    }
    
    public func display(request: MVVMCNavigationRequest, animated: Bool) {
        guard tabBar.selectedIndex < modules.count, tabBar.selectedIndex != NSNotFound else { return }
        let currentModule = modules[tabBar.selectedIndex]
        currentModule.coordinator.request(navigation: request, withData: nil, animated: animated)
    }
}

// MARK: - UITabBarControllerDelegate
extension MVVMCTabbedAppCoordinator: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        guard let viewController = viewController as? UINavigationController else {
//            return
//        }

//        startTab(viewController: viewController)
    }
}
