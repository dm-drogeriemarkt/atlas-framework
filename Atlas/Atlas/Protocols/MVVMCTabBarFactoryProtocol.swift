import UIKit

public protocol MVVMCTabBarFactoryProtocol: MVVMCFactoryProtocol {
    var tabBarItemTitle: String? { get }
    var selectedTabBarIconImage: UIImage? { get }
    var unselectedTabBarIconImage: UIImage? { get }
    var tabBarTitle: String? { get }
    var prefersLargeTitles: Bool { get }
}

// MARK: - Default values
public extension MVVMCTabBarFactoryProtocol {
    var tabBarTitle: String? {
        return nil
    }
}
