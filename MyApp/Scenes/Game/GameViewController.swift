import UIKit
import SnapKit

final class GameViewController: UIViewController, UISearchBarDelegate {

    var games: [Game] = [] // Array to hold game data fetched from the API
    
    let tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.register(GameUITableViewCell.self, forCellReuseIdentifier: GameUITableViewCell.identifier)
        return tableView
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search for the games"
        searchBar.layer.borderWidth = 0
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        getGames()
        view.backgroundColor = .systemBackground
        title = "Games"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        configureConstraints()
    }
    
    private func getGames() {
        let urlString = "https://api.rawg.io/api/games?page_size=5&page=1"
        
        NetworkManager.shared.fetchGames(urlString: urlString) { [weak self] result in
            switch result {
            case .success(let games):
                DispatchQueue.main.async {
                    self?.games = games // Assigning fetched games to the "games" array
                    self?.tableView.reloadData() //Reloading table
                }
            case .failure(let error):
                print("Error fetching games: \(error.localizedDescription)")
            }
        }
    }
    
    private func configureConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading).offset(7)
            make.trailing.equalTo(view.snp.trailing).offset(-7)
            make.height.equalTo(60)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalTo(view)
        }
    }
}


extension GameViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let game = games[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: GameUITableViewCell.identifier, for: indexPath) as! GameUITableViewCell
        
        // Downloading image data asynchronously and set it in the cell
        if let imageUrl = URL(string: game.backgroundImage) {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                if let data = data, error == nil {
                    DispatchQueue.main.async {
                        cell.configure(image: UIImage(data: data), titleText: game.name, metaCriticText: "\(game.metacritic ?? 0)", categoriesText: game.genres.map { $0.name }.joined(separator: ", "))
                    }
                }
            }.resume()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGame = games[indexPath.row]
        
        let detailVC = GameDetailViewController()
        detailVC.gameId = selectedGame.id  // Passing the selected game's ID to detailVC.
        
        // Downloading the image data asynchronously and passing it to detailVC.
        if let imageUrl = URL(string: selectedGame.backgroundImage) {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                if let data = data, error == nil {
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        detailVC.configure(with: image, title: selectedGame.name)
                        self.navigationController?.pushViewController(detailVC, animated: true)
                    }
                } else {
                    DispatchQueue.main.async {
                        detailVC.configure(with: nil, title: selectedGame.name)
                        self.navigationController?.pushViewController(detailVC, animated: true)
                    }
                }
            }.resume()
        } else {
            detailVC.configure(with: nil, title: selectedGame.name)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
