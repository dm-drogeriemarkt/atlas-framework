public protocol MVVMCAppCoordinator: AnyObject {
    func start()
    func deepLink(chain: [MVVMCNavigationRequest], selectedTab: Int?, completion: (() -> Void)?)
}

public extension MVVMCAppCoordinator {
    func deepLink(chain: [MVVMCNavigationRequest], selectedTab: Int?) {
        guard let selectedTab = selectedTab else { return }
        deepLink(chain: chain, selectedTab: selectedTab, completion: nil)
    }
}
