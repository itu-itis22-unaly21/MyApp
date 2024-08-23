import Foundation

struct Game: Decodable {
    let id: Int
    let name: String
    let backgroundImage: String
    let metacritic: Int?
    let genres: [Genre]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case backgroundImage = "background_image"
        case metacritic
        case genres
    }
}

struct GameDetail: Decodable {
    let id: Int
    let name: String
    let description: String
    let website: String?
    let redditURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description = "description_raw"
        case website
        case redditURL = "reddit_url"
    }
}

struct Genre: Decodable {
    let name: String
}

struct GameResponse: Decodable {
    let results: [Game]
}
