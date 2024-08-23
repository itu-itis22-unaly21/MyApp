import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    private let apiKey = "3be8af6ebf124ffe81d90f514e59856c"
    
    func fetchGames(urlString: String, completion: @escaping (Result<[Game], Error>) -> Void) {
        guard var urlComponents = URLComponents(string: urlString) else {
            return
        }
        
        let queryItems = [
            URLQueryItem(name: "key", value: apiKey)
        ]
        urlComponents.queryItems?.append(contentsOf: queryItems)
        
        guard let url = urlComponents.url else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let noDataError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data returned"])
                completion(.failure(noDataError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let gameResponse = try decoder.decode(GameResponse.self, from: data)
                let games = gameResponse.results
                completion(.success(games))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchGameDetails(gameId: Int, completion: @escaping (Result<GameDetail, Error>) -> Void) {
       
        let urlString = "https://api.rawg.io/api/games/\(gameId)?key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let noDataError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data returned"])
                completion(.failure(noDataError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let gameDetail = try decoder.decode(GameDetail.self, from: data)
                completion(.success(gameDetail))
                print(gameDetail)
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
