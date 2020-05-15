import Foundation


enum NetworkingError: Error { // мб NetworkError?
    case `default`
    
    var localizedDescription: String {
        switch self {
        case .default: return "Networking Error" // и где тут локазизация? NSLocalizedString
        }
    }
}


enum CommonError: Error {
    case `default`
    
    var localizedDescription: String {
        switch self {
        case .default: return "Something went wrong"
        }
    }
}
