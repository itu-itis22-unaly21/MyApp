import SnapKit
import UIKit

final class GameDetailViewController: UIViewController {
    
    var gameId: Int? // Oyun ID'si
    private let gameImageView = UIImageView()
    private let gameTitleLabel = UILabel()
    private let gameDescriptionHeaderLabel = UILabel()
    private let gameDescriptionLabel = UILabel()
    private let visitRedditButton = UIButton()
    private let visitWebsiteButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupSubviews()
        setupConstraints()
        applyGradientToImageView()
        
        // Oyun detaylarını çek
        if let gameId = gameId {
            fetchGameDetails(gameId: gameId)
        } else {
            print("Game ID yok")
        }
    }
    
    private func setupSubviews() {
        gameImageView.contentMode = .scaleToFill
        view.addSubview(gameImageView)
        
        gameTitleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        gameTitleLabel.textColor = .white
        gameTitleLabel.textAlignment = .right
        gameTitleLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(gameTitleLabel)
        
        gameDescriptionHeaderLabel.font = UIFont.systemFont(ofSize: 17)
        gameDescriptionHeaderLabel.textColor = .black
        gameDescriptionHeaderLabel.text = "Game Description"
        view.addSubview(gameDescriptionHeaderLabel)
        
        gameDescriptionLabel.font = UIFont.systemFont(ofSize: 10)
        gameDescriptionLabel.numberOfLines = 0
        gameDescriptionLabel.textColor = .black
        view.addSubview(gameDescriptionLabel)
        
        visitRedditButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        visitRedditButton.setTitleColor(.black, for: .normal)
        visitRedditButton.contentHorizontalAlignment = .left
        view.addSubview(visitRedditButton)
        
        visitWebsiteButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        visitWebsiteButton.setTitleColor(.black, for: .normal)
        visitWebsiteButton.contentHorizontalAlignment = .left
        view.addSubview(visitWebsiteButton)
    }
    
    private func setupConstraints() {
        gameImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(88)
            make.width.equalTo(375)
            make.height.equalTo(291)
            make.centerX.equalToSuperview()
        }
        
        gameTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(320)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(343)
            make.height.equalTo(43)
        }
        
        gameDescriptionHeaderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(395)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(343)
            make.height.equalTo(21)
        }
        
        gameDescriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(424)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(343)
            make.height.equalTo(81)
        }
        
        visitRedditButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(537)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(343)
            make.height.equalTo(22)
        }
        
        visitWebsiteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(592)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(343)
            make.height.equalTo(22)
        }
    }
    
    private func applyGradientToImageView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gameImageView.bounds
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.8).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gameImageView.layer.addSublayer(gradientLayer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gameImageView.layer.sublayers?.first?.frame = gameImageView.bounds
    }
    
    func configure(with image: UIImage?, title: String) {
        gameImageView.image = image
        gameTitleLabel.text = title
    }
    
    func configureDescriptionAndLinks(description: String, redditLink: String, websiteLink: String) {
        gameDescriptionLabel.text = description
        visitRedditButton.setTitle(redditLink, for: .normal)
        visitWebsiteButton.setTitle(websiteLink, for: .normal)
    }
    
    private func fetchGameDetails(gameId: Int) {
        NetworkManager.shared.fetchGameDetails(gameId: gameId) { [weak self] result in
            switch result {
            case .success(let gameDetail):
                DispatchQueue.main.async {
                    self?.configureDescriptionAndLinks(description: gameDetail.description, redditLink: gameDetail.redditURL ?? "No Reddit Link", websiteLink: gameDetail.website ?? "No Website")
                }
            case .failure(let error):
                print("Error fetching game details: \(error.localizedDescription)")
            }
        }
    }
}
