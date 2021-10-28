protocol MVVMCChildCoordinatorDelegate: AnyObject {
    func childCoordinatorRequestsDismissal(_ coordinator: MVVMCCoordinatorProtocol, transitionType: MVVMCTransitionType, animated: Bool)
}
