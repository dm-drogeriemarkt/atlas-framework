protocol MVVMCCoordinatorProtocol: MVVMCStartable, MVVMCChildCoordinatorDelegate, MVVMCViewDelegate {
    var targetCoordinator: MVVMCCoordinatorProtocol? { get }
    var coordinatorDelegate: MVVMCChildCoordinatorDelegate? { get set }
}
