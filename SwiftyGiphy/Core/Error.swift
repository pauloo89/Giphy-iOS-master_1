import Foundation


enum NetworkingError: Error {
    case `default`
    
    var localizedDescription: String {
        switch self {
        case .default: return "Networking Error"
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
