import Foundation
import Alamofire


protocol Networking {
    func request(
        url: String,
        method: Alamofire.HTTPMethod,
        parameters: [String: Any],
        completion: @escaping (Swift.Result<Data, Error>) -> Void
    )
}


class NetworkingImpl: Networking {
    func request(
        url: String,
        method: Alamofire.HTTPMethod,
        parameters: [String: Any],
        completion: @escaping (Swift.Result<Data, Error>) -> Void
    ) {
        AF.request(
            url,
            method: method,
            parameters: parameters,
            encoding: method == .get ? URLEncoding.queryString : JSONEncoding.default
        ).responseJSON { responseJson in
            switch responseJson.result {
            case .success:
                guard let data = responseJson.data else {
                    completion(.failure(CommonError.default))
                    return
                }
                completion(.success(data))
            case .failure(let error):
                print(error)
                completion(.failure(CommonError.default))
            }
        }
    }
}
