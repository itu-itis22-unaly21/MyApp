import SnapKit
import UIKit

class GameUITableViewCell: UITableViewCell {
    static let identifier = "GameUITableViewCell"
    
    var gameImageView: UIImageView = {
        let image: UIImageView = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    let title: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont(name: "Roboto" , size: 20)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    let metaCriticLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.text = "metacritic: "
        return label
    }()

    
    let metaCritic: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont(name: "Roboto", size: 18)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .red
        return label
    }()
    
    let categories: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont(name: "Roboto", size: 13)
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(gameImageView)
        contentView.addSubview(title)
        contentView.addSubview(metaCriticLabel)
        contentView.addSubview(metaCritic)
        contentView.addSubview(categories)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        gameImageView.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(104)
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        title.snp.makeConstraints { make in
            make.width.equalTo(207)
            make.height.equalTo(27)
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(gameImageView.snp.right).offset(16)
        }
        
        metaCriticLabel.snp.makeConstraints { make in
            make.width.equalTo(76)
            make.height.equalTo(16)
            make.top.equalToSuperview().offset(84)
            make.left.equalTo(gameImageView.snp.right).offset(16)
        }
        
        metaCritic.snp.makeConstraints { make in
            make.width.equalTo(26)
            make.height.equalTo(16)
            make.top.equalToSuperview().offset(84)
            make.left.equalTo(metaCriticLabel.snp.right).offset(4)
        }
        
        categories.snp.makeConstraints { make in
            make.width.equalTo(207)
            make.height.equalTo(16)
            make.top.equalTo(metaCriticLabel.snp.bottom).offset(8)
            make.left.equalTo(gameImageView.snp.right).offset(16)
        }
    }

    func configure(image: UIImage?, titleText: String, metaCriticText: String, categoriesText: String) {
        gameImageView.image = image
        title.text = titleText
        metaCritic.text = metaCriticText
        categories.text = categoriesText
    }
}
