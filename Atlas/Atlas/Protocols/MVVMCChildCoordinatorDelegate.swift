protocol MVVMCChildCoordinatorDelegate: class {
    func childCoordinatorRequestsDismissal(_ coordinator: MVVMCCoordinatorProtocol, transitionType: MVVMCTransitionType, animated: Bool)
}
