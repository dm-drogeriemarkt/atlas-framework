import Atlas

class BlueFactory {
    var transitionType: MVVMCTransitionType = .push(animated: false)
    var selectedTabBarIconImage: UIImage? = nil
    var unselectedTabBarIconImage: UIImage? = nil
    var tabBarItemTitle: String? = "Blue"
    var prefersLargeTitles = true
    var didSetupModule: ((UINavigationController, UITabBarController, MVVMCViewDelegate) -> Void)? = nil
}


// MARK: - MVVMCTabBarFactoryProtocol
extension BlueFactory: MVVMCTabBarFactoryProtocol {
    func target(forIdentifier: MVVMCNavigationTarget) -> MVVMCFactoryProtocol? {
        switch forIdentifier {
            case NavigationTargets.yellow: return YellowFactory()
            default: return nil
        }
    }
    
    func createView(model: MVVMCModelProtocol, delegate: MVVMCViewDelegate) -> UIViewController {
        let blueView = BlueView.create()
        var viewModel = BlueViewModel()
        viewModel.coordinatorDelegate = delegate
        blueView.viewModel = viewModel
        return blueView
    }
}
