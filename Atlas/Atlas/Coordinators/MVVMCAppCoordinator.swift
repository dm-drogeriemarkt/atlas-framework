public protocol MVVMCAppCoordinator: AnyObject {
    func start()
    func deepLink(chain: [MVVMCNavigationRequest], selectedTab: Int?, completion: (() -> Void)?)
    func display(request: MVVMCNavigationRequest, animated: Bool)
}

public extension MVVMCAppCoordinator {
    func deepLink(chain: [MVVMCNavigationRequest], selectedTab: Int?) {
        guard let selectedTab = selectedTab else { return }
        deepLink(chain: chain, selectedTab: selectedTab, completion: nil)
    }
    
    func display(request: MVVMCNavigationRequest) {
        display(request: request, animated: true)
    }
}
