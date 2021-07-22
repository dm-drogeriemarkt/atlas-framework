import UIKit

public class MVVMCAppCoordinator: NSObject {
    let model: MVVMCModelProtocol
    let window: UIWindow
    let tabBar: UITabBarController
    var modules: [MVVMCModule]
    
    private var isStarted = false
    private var queuedDeepLinks: [([MVVMCNavigationRequest], Int)] = .init()
    
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
        triggerQueuedDeepLinks()
    }
    
    private func triggerQueuedDeepLinks() {
        queuedDeepLinks.forEach { self.deepLink(chain: $0.0, selectedTab: $0.1) }
        queuedDeepLinks.removeAll()
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
    
    public func deepLink(chain: [MVVMCNavigationRequest], selectedTab: Int) {
        guard isStarted else {
            queuedDeepLinks.append((chain, selectedTab))
            return
        }
        let module = modules[selectedTab]
        module.navigationController.dismiss(animated: false, completion: nil)
        tabBar.selectedIndex = selectedTab
        module.navigationController.popToRootViewController(animated: false)
        var coordinator: MVVMCCoordinatorProtocol? = module.coordinator
            
        for request in chain {
            coordinator?.request(navigation: request, withData: [:], animated: false)
            coordinator = coordinator?.targetCoordinator
        }
    }
}

// MARK: - UITabBarControllerDelegate
extension MVVMCAppCoordinator: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        guard let viewController = viewController as? UINavigationController else {
//            return
//        }
        
//        startTab(viewController: viewController)
    }
}
