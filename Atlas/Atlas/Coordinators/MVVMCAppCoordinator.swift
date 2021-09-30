public protocol MVVMCAppCoordinator: AnyObject {
    func start()
    func deepLink(chain: [MVVMCNavigationRequest], selectedTab: Int?, completion: (() -> Void)?)
}
