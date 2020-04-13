import UIKit


protocol MainAssembly {
    func mainViewController() -> MainViewController
}


final class MainAssemblyDefault {
    private func createMainViewController() -> MainViewController {
        let api = createApi(networking: createNetworking())
        let output = MainPresenter(service: createService(api: api))
        
        let controller = MainViewController(output: output)
        output.set(viewInput: controller)
        
        return controller
    }
    
    private func createService(api: API) -> GiphyService {
        return GiphyServiceImpl(api: api)
    }
    
    private func createApi(networking: Networking) -> API {
        return GiphyAPI(networking: createNetworking())
    }
    
    private func createNetworking() -> Networking {
        return NetworkingImpl()
    }
}


extension MainAssemblyDefault: MainAssembly {
    func mainViewController() -> MainViewController {
        return createMainViewController()
    }
}
