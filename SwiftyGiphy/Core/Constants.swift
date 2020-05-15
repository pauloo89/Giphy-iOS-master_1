import Foundation

// эти константы является глобальными для приложения, все классы их видят.
// тем более, что они относятся только к GiphyAPI. вот пусть будут объявлены как private
enum Constants {
    static let baseUrl = "https://api.giphy.com/v1/gifs"
    static let apiKey = "bxBuZ7LB6wNwpRaPCkBJ9T0l7HrgdJhb"
    static let queryDataLimit = 10
}

