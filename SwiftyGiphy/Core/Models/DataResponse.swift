import Foundation


struct DataResponse<T> where T: Codable {
    let data: [T]
    let meta: Meta?
}


extension DataResponse: Codable {
    struct Meta: Codable {
        let status: Int?
        let msg: String?
    }
}
