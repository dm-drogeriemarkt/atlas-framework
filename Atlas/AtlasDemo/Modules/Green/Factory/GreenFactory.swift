import Atlas

class GreenFactory {
    var transitionType: MVVMCTransitionType = .push(animated: false)
    var selectedTabBarIconImage: UIImage? = nil
    var unselectedTabBarIconImage: UIImage? = nil
    var tabBarItemTitle: String? = "Green"
    var prefersLargeTitles = true
    var didSetupModule: ((UINavigationController, UITabBarController, MVVMCViewDelegate) -> Void)? = nil
}


// MARK: - MVVMCTabBarFactoryProtocol
extension GreenFactory: MVVMCTabBarFactoryProtocol {
    func target(forIdentifier: MVVMCNavigationTarget) -> MVVMCFactoryProtocol? {
        switch forIdentifier {
            case NavigationTargets.red(let parameter): return RedFactory(parameter: parameter)
            default: return nil
        }
    }
    
    func createView(model: MVVMCModelProtocol, delegate: MVVMCViewDelegate) -> UIViewController {
        let greenView = GreenView.create()
        var viewModel = GreenViewModel()
        viewModel.coordinatorDelegate = delegate
        greenView.viewModel = viewModel
        return greenView
    }
}

