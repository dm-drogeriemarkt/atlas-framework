import Foundation
import Atlas

class YellowViewModel {
    let model: DemoModel
    
    var title = "Blue"
    var color: (red: Float, green: Float, blue: Float) = (red: 255.0, green: 255.0, blue: 0.0)
    var text = "Press the button to dismiss this view"
    var buttonTitle = "Dismiss"
    var timer = Timer()

    weak var coordinatorDelegate: MVVMCViewDelegate?
    weak var viewDelegate: YellowViewDelegate?

    init(model: MVVMCModelProtocol) {
        self.model = model as! DemoModel
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(YellowViewModel.updateCounter)), userInfo: nil, repeats: true)
    }
}

// MARK: - YellowViewModelProtocol
extension YellowViewModel: YellowViewModelProtocol {
    var count: Int {
        return model.count
    }
    
    func dismiss() {
        timer.invalidate()
        coordinatorDelegate?.request(navigation: MVVMCNavigationRequest.dismiss, withData: nil)
    }
}

// MARK: - Timer
extension YellowViewModel {
    @objc func updateCounter() {
        model.increase()
        viewDelegate?.countDidChange()
    }
}
