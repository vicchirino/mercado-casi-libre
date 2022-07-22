//
//  ItemTableCell.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 21/07/2022.
//

import UIKit
import SnapKit
import SDWebImage

class ItemTableViewCell: UITableViewCell {

    static var identifier: String = "ItemTableViewCell"
        
    private lazy var title: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .darkText
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 16.0)
        return label
    }()

    private lazy var price: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .darkText
        label.font = .systemFont(ofSize: 26.0)
        return label
    }()
    
    private lazy var itemImageViewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var itemImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var spacer: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var textContainerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [title, price, spacer])
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [itemImageViewContainer, textContainerStackView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
        price.text = nil
        itemImageView.image = nil
        itemImageView.sd_cancelCurrentImageLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .white
        addSubview(containerStackView)
        selectionStyle = .none
        
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
        
        itemImageViewContainer.addSubview(itemImageView)
        
        containerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        itemImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        itemImageViewContainer.snp.makeConstraints { make in
            make.width.equalTo(150)
        }

        title.snp.makeConstraints { make in
            make.leading.equalTo(textContainerStackView.snp.leading)
            make.top.equalTo(textContainerStackView.snp.top)
            make.trailing.equalTo(textContainerStackView.snp.trailing)
            make.height.equalTo(50)
        }
    }
    
    func configureCell(item: Item) {
        title.text = item.title
        title.sizeToFit()
        price.text = "$\(item.price)"
        price.sizeToFit()
        itemImageView.sd_setImage(with: URL(string: item.imageURL))
    }
    
}

