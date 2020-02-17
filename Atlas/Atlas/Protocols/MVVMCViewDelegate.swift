import UIKit

public protocol MVVMCViewDelegate: class {
    func request(navigation request: MVVMCNavigationRequest, withData data: [String: Any]?)
    func requestUpdate(withData data: [String : Any]?)
    
    @available(*, deprecated, message: "Use update and handle the view updates in the factory")
    func reload()
}
