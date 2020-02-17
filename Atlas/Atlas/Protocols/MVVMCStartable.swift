public protocol MVVMCStartable {
    func start(skipAnimation: Bool)
}

// MARK: - Enable default parameter for skipAnimation
extension MVVMCStartable {
    func start() {
        start(skipAnimation: false)
    }
}
