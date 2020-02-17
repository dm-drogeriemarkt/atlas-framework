import Atlas

struct GreenViewModel {
    var title = "Green"
    var color: (red: Float, green: Float, blue: Float) = (red: 0.0, green: 255.0, blue: 0.0)
    var text = "Press the button to push a new view and transfer the parameter from the text field"
    var buttonTitle = "Push"
    var defaultText = "Change me"
    
    weak var coordinatorDelegate: MVVMCViewDelegate?
}

// MARK: - GreenViewModelProtocol
extension GreenViewModel: GreenViewModelProtocol {
    func showRedView(withParameter parameter: String) {
        coordinatorDelegate?.request(navigation: MVVMCNavigationRequest.request(target: NavigationTargets.red(parameter: parameter)), withData: nil)
    }
}
