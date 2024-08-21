import UIKit
import SnapKit

final class GameViewController: UIViewController, UISearchBarDelegate {
    
    let gameModel: [UIImage] = [UIImage(named: "gta5")!]
    
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
        
        view.backgroundColor = .systemBackground
        title = "Games"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        configureConstraints()
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
        gameModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = gameModel[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: GameUITableViewCell.identifier, for: indexPath) as! GameUITableViewCell
        cell.configure(image: data, titleText: "Grand Theft Auto V", metaCriticText: "96", categoriesText: "Action, shooter")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        136
    }
}
