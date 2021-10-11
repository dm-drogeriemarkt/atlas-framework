import UIKit
import Atlas

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: MVVMCAppCoordinator!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        let model = DemoModel()
        appCoordinator = MVVMCTabbedAppCoordinator(model: model, window: window!, factories: [BlueFactory(), GreenFactory()])
        appCoordinator.start()

        return true
    }
}
