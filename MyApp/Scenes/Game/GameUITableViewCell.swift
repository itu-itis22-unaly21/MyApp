import UIKit
import SnapKit

class GameUITableViewCell: UITableViewCell {
    static let identifier = "GameUITableViewCell"
    
    var gameImageView: UIImageView = {
        let image: UIImageView = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    let title: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont(name: "Roboto-Bold" , size: 20)
        label.textColor = .black
        return label
    }()
    
    let metaCritic: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        label.textColor = .red
        return label
    }()
    
    let categories: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 13)
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(gameImageView)
        contentView.addSubview(title)
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
            make.left.equalTo(gameImageView.snp.right).offset(16)
            make.top.equalTo(gameImageView.snp.top)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(27)
        }
        
        metaCritic.snp.makeConstraints { make in
            make.left.equalTo(title.snp.left)
            make.top.equalTo(title.snp.bottom).offset(8)
            make.height.equalTo(16)
        }
        
        categories.snp.makeConstraints { make in
            make.left.equalTo(title.snp.left)
            make.top.equalTo(metaCritic.snp.bottom).offset(8)
            make.height.equalTo(16)
            make.right.equalToSuperview().offset(-16)
        }
    }

    func configure(image: UIImage?, titleText: String, metaCriticText: String, categoriesText: String) {
        gameImageView.image = image
        title.text = titleText
        metaCritic.text = metaCriticText
        categories.text = categoriesText
    }
}
