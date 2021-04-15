public enum MVVMCNavigationRequest {
    case dismiss
    case request(target: MVVMCNavigationTarget)

    var navigationTarget: MVVMCNavigationTarget? {
        switch self {
            case .dismiss: return nil
            case .request(let value): return value
        }
    }
}
