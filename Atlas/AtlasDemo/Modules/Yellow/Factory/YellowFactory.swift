import Atlas

class YellowFactory {
    var transitionType: MVVMCTransitionType = .modal(animated: true)
}


// MARK: - MVVMCTabBarFactoryProtocol
extension YellowFactory: MVVMCFactoryProtocol {
    func target(forIdentifier: MVVMCNavigationTarget) -> MVVMCFactoryProtocol? {
        return nil
    }
    
    func createView(model: MVVMCModelProtocol, delegate: MVVMCViewDelegate) -> UIViewController {
        let yellowView = YellowView.create()
        let viewModel = YellowViewModel(model: model)
        viewModel.coordinatorDelegate = delegate
        viewModel.viewDelegate = yellowView
        yellowView.viewModel = viewModel
        return yellowView
    }
}
