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
    
    private lazy var itemStockView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        return view
    }()
    
    private lazy var itemDescriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGrayColor
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [itemHeaderStackView, itemPicturesView, itemPriceLabel, itemStockView, itemDescriptionView])
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
        
        itemStockView.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        itemDescriptionView.snp.makeConstraints { make in
            make.height.equalTo(600)
        }
    }
    
    func configure(withItem item: Item) {
        itemTitleLabel.text = item.title
        itemConditionlabel.text = "\(item.condition.capitalized) | \(item.soldQuantity) vendidos"
        itemPriceLabel.text = NumberFormatter.localizedString(from: NSNumber(value: item.price), number: .currency)
        itemPicturesView.configure(withPictures: item.pictures)
    }
    
}
