import Foundation

// все данные с сервера будут такого вида? а если надо будет что-то еще загрузить?
// нейминг слишком общий, а реализация слишком конкретная
struct DataResponse<T> where T: Codable {
    let data: [T]
    let meta: Meta?
}


extension DataResponse: Codable {
    struct Meta: Codable {
        let status: Int? // статус предполагает перечисление, а здесь число. мб statusCode?
        let msg: String? // типо это message?
    }
}
