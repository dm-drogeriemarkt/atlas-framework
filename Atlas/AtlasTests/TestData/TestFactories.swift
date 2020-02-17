import Atlas

class StateFactory: MVVMCFactoryProtocol {
    var transitionType = MVVMCTransitionType.push(animated: false)
    
    func target(forIdentifier: MVVMCNavigationTarget) -> MVVMCFactoryProtocol? {
        return GreenFactory()
    }

    func createView(model: MVVMCModelProtocol, delegate: MVVMCViewDelegate) -> UIViewController {
        if (model as! ModelMock).isLoggedIn {
            return BlueTestViewController()
        }

        return RedTestViewController()
    }
}

class GreenFactory: MVVMCFactoryProtocol {
    var transitionType = MVVMCTransitionType.push(animated: false)
    
    func target(forIdentifier: MVVMCNavigationTarget) -> MVVMCFactoryProtocol? {
        return BlueFactory()
    }

    func createView(model: MVVMCModelProtocol, delegate: MVVMCViewDelegate) -> UIViewController {
        let vc = GreenTestViewController()
        vc.delegate = delegate
        return vc
    }
}

class BlueFactory: MVVMCFactoryProtocol {
    var transitionType = MVVMCTransitionType.modal(animated: false)
    
    func target(forIdentifier: MVVMCNavigationTarget) -> MVVMCFactoryProtocol? {
        return nil
    }

    func createView(model: MVVMCModelProtocol, delegate: MVVMCViewDelegate) -> UIViewController {
        return UIViewController()
    }
}

class Feature1Factory: MVVMCTabBarFactoryProtocol {
    var tabBarItemTitle: String? = "Feature1Factory"
    var prefersLargeTitles = true
    var selectedTabBarIconImage = UIImage.loadTestImage(named: "CircleSelected")
    var unselectedTabBarIconImage = UIImage.loadTestImage(named: "CircleUnselected")
    var transitionType = MVVMCTransitionType.push(animated: false)
    var didSetupModule: ((UINavigationController, UITabBarController, MVVMCViewDelegate) -> Void)?

    func target(forIdentifier: MVVMCNavigationTarget) -> MVVMCFactoryProtocol? {
        return nil
    }

    func createView(model: MVVMCModelProtocol, delegate: MVVMCViewDelegate) -> UIViewController {
        let vc = GreenTestViewController()
        vc.delegate = delegate
        return vc
    }
}

class Feature2Factory: MVVMCTabBarFactoryProtocol {
    var tabBarItemTitle: String? = "Feature2Factory"
    var prefersLargeTitles = true
    var selectedTabBarIconImage = UIImage.loadTestImage(named: "DiamondSelected")
    var unselectedTabBarIconImage = UIImage.loadTestImage(named: "DiamondUnselected")
    var transitionType = MVVMCTransitionType.push(animated: false)
    var didSetupModule: ((UINavigationController, UITabBarController, MVVMCViewDelegate) -> Void)?

    func target(forIdentifier: MVVMCNavigationTarget) -> MVVMCFactoryProtocol? {
        return nil
    }

    func createView(model: MVVMCModelProtocol, delegate: MVVMCViewDelegate) -> UIViewController {
        let vc = BlueTestViewController()
        vc.delegate = delegate
        return vc
    }
}
