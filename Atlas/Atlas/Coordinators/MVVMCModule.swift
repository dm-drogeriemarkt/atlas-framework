import UIKit

struct MVVMCModule {
    let factory: MVVMCTabBarFactoryProtocol
    let navigationController: UINavigationController
    let coordinator: MVVMCCoordinatorProtocol
}
