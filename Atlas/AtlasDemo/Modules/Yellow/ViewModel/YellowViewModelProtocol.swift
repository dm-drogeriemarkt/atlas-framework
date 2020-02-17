import Atlas

protocol YellowViewModelProtocol {
    var title: String { get }
    var color: (red: Float, green: Float, blue: Float) { get }
    var text: String { get }
    var buttonTitle: String { get }
    var count: Int { get }
    var coordinatorDelegate: MVVMCViewDelegate? { get set }
    var viewDelegate: YellowViewDelegate? { get set }

    func dismiss()
}
