import Atlas

class MVVMCTabBarFactoryWithTitle: MVVMCTabBarFactoryProtocol {
    var selectedTabBarIconImage: UIImage? = nil
    var unselectedTabBarIconImage: UIImage? = nil
    var tabBarTitle: String? = "TabBarTitle"
    var prefersLargeTitles: Bool = false
    var didSetupModule: ((UINavigationController, UITabBarController, MVVMCViewDelegate) -> Void)? = nil
    var transitionType: MVVMCTransitionType = .push(animated: false)
    
    func target(forIdentifier: MVVMCNavigationTarget) -> MVVMCFactoryProtocol? {
        return nil
    }
    
    func createView(model: MVVMCModelProtocol, delegate: MVVMCViewDelegate) -> UIViewController {
        return UIViewController()
    }
}

class MVVMCTabBarFactoryWithoutTitle: MVVMCTabBarFactoryProtocol {
    var selectedTabBarIconImage: UIImage? = nil
    var unselectedTabBarIconImage: UIImage? = nil
    var prefersLargeTitles: Bool = false
    var didSetupModule: ((UINavigationController, UITabBarController, MVVMCViewDelegate) -> Void)? = nil
    var transitionType: MVVMCTransitionType = .push(animated: false)
    
    func target(forIdentifier: MVVMCNavigationTarget) -> MVVMCFactoryProtocol? {
        return nil
    }
    
    func createView(model: MVVMCModelProtocol, delegate: MVVMCViewDelegate) -> UIViewController {
        return UIViewController()
    }
}
