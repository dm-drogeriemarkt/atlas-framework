import UIKit

struct MVVMCModule {
    let factory: MVVMCFactoryProtocol
    let navigationController: UINavigationController
    let coordinator: MVVMCCoordinatorProtocol
}
