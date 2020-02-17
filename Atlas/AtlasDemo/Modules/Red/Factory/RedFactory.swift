import Atlas

class RedFactory {
    let parameter: String
    
    var transitionType: MVVMCTransitionType = .push(animated: true)
    
    init(parameter: String) {
        self.parameter = parameter
    }
}


// MARK: - MVVMCTabBarFactoryProtocol
extension RedFactory: MVVMCFactoryProtocol {
    func target(forIdentifier: MVVMCNavigationTarget) -> MVVMCFactoryProtocol? {
        return nil
    }
    
    func createView(model: MVVMCModelProtocol, delegate: MVVMCViewDelegate) -> UIViewController {
        let redView = RedView.create()
        var viewModel = RedViewModel(withParameter: parameter)
        viewModel.coordinatorDelegate = delegate
        redView.viewModel = viewModel
        return redView
    }
}

