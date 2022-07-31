//
//  ItemDetailVIew.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 29/07/2022.
//

import UIKit
import SnapKit

class ItemDetailView: UIView {
    
    var item: Item!
    
    private lazy var mainScollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var itemConditionlabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .darkTextColor
        label.font = .systemFont(ofSize: 12.0)
        return label
    }()
    
    private lazy var itemTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .darkTextColor
        label.font = .systemFont(ofSize: 16.0)
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var itemHeaderStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [itemConditionlabel, itemTitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var itemPicturesView: ItemPicturesView = {
        let view = ItemPicturesView()
        return view
    }()
    
    private lazy var itemPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .darkTextColor
        label.font = .boldSystemFont(ofSize: 24.0)
        return label
    }()
    
    private lazy var availableQuantityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .darkTextColor
        label.font = .systemFont(ofSize: 18.0)
        return label
    }()

    private lazy var itemStockStackView: UIStackView = {
        let view = UIView()
        let stackView = UIStackView(arrangedSubviews: [availableQuantityLabel])
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .equalSpacing
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layer.cornerRadius = 5
        stackView.backgroundColor = .lightGrayColor
        return stackView
    }()
    
    private lazy var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Descripcion:"
        label.textColor = .darkTextColor
        label.font = .boldSystemFont(ofSize: 24.0)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .darkTextColor
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 1000
        return label
    }()
    
    private lazy var itemDescriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [descriptionTitleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.layer.cornerRadius = 5
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = .lightGrayColor
        stackView.alpha = 0
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [itemHeaderStackView, itemPicturesView, itemPriceLabel, itemStockStackView, itemDescriptionStackView])
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(mainScollView)
        mainScollView.addSubview(mainStackView)
                
        mainScollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        itemPicturesView.snp.makeConstraints { make in
            make.height.equalTo(300)
        }
        
        itemStockStackView.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
    }
    
    func configure(withItem item: Item) {
        itemTitleLabel.text = item.title
        itemConditionlabel.text = "\(item.condition.capitalized) | \(item.soldQuantity) vendidos"
        itemPriceLabel.text = NumberFormatter.localizedString(from: NSNumber(value: item.price), number: .currency)
        itemPicturesView.configure(withPictures: item.pictures)
        availableQuantityLabel.text = "\(item.availableQuantity) disponibles"
    }
    
    func setItemDescription(text: String) {
        guard text != "" else {
            return
        }
        descriptionLabel.text = text
        itemDescriptionStackView.alpha = 1
    }
    
}
