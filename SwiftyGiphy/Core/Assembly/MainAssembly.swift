import UIKit


protocol MainAssembly {
  // что mainViewController? что он делает?
  // func assembleMainViewController говорит о том, что он сейчас соберет модуль
  // -> MainViewController. зачем тому, кто будет его использовать, знать конкретный тип VC?
  // хватит обычного UIViewController
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

  // а смысл объявления метода, который сразу возвращает объект? только класс раздувается
  // createNetworking вызывается 4 раза. так и задумано?
    private func createNetworking() -> Networking {
        return NetworkingImpl()
    }
}


extension MainAssemblyDefault: MainAssembly {
    func mainViewController() -> MainViewController {
        return createMainViewController()
    }
}
