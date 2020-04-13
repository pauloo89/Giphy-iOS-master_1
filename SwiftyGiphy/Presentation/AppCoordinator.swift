import UIKit


final class AppCoordinator {
    private(set) var rootController: UIViewController?
    private let configurator: MainAssembly
    
    init(configurator: MainAssembly) {
        self.configurator = configurator
        rootController = configurator.mainViewController()
    }
    
    func start() {
        UIApplication.shared.delegate?.window??.rootViewController = configurator.mainViewController()
    }
}
