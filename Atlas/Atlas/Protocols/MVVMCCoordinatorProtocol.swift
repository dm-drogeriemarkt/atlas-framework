protocol MVVMCCoordinatorProtocol: MVVMCStartable, MVVMCChildCoordinatorDelegate, MVVMCViewDelegate {
    var coordinatorDelegate: MVVMCChildCoordinatorDelegate? { get set }
}
