import UIKit
import SnapKit

final class GameDetailViewController: UIViewController {
    
    private let gameImageView = UIImageView()
    private let gameTitleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupSubviews()
        setupConstraints()
        applyGradientToImageView()
    }
    
    private func setupSubviews() {
        gameImageView.contentMode = .scaleToFill
        view.addSubview(gameImageView)
        
        gameTitleLabel.font = UIFont(name: "Roboto", size: 36)//I tried to make the name "Roboto-Bold" but it didn't change the boldness
        gameTitleLabel.font = UIFont.boldSystemFont(ofSize: 36)//and it asked for size again that's why i set size twice
        gameTitleLabel.textColor = .white
        gameTitleLabel.textAlignment = .right
        gameTitleLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(gameTitleLabel)
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
        // Ensure the gradient layer covers the entire image view
        gameImageView.layer.sublayers?.first?.frame = gameImageView.bounds
    }
    
    func configure(with image: UIImage?, title: String) {
        gameImageView.image = image
        gameTitleLabel.text = title
    }
}
