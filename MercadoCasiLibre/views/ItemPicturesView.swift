//
//  ItemsPicturesView.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 29/07/2022.
//

import UIKit
import SnapKit
import SDWebImage

private let PICTURES_PADDING = 20.0

class ItemPicturesView: UIView {
    
    private var pictures: [Item.Picture] = []
    private var currentPage: Int = 0
    
    private lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private lazy var scrollContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: PICTURES_PADDING/2, bottom: 0, right: PICTURES_PADDING/2)
        stackView.spacing = PICTURES_PADDING
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    // TODO: - Add page indicator label above scroll.
    private lazy var pageIndicatorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .darkTextColor
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 10.0)
        label.backgroundColor = .white
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.lightGrayColor.cgColor
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mainScrollView])
        stackView.layoutMargins = UIEdgeInsets(top: PICTURES_PADDING, left: 0, bottom: PICTURES_PADDING, right: 0)
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
    
    private func buildAlbum() {
        for picture in pictures {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.sd_setImage(with: URL(string: picture.url))
            imageView.sd_setImage(with: URL(string: picture.url), placeholderImage: UIImage(named: "placeholder.png"))

            scrollContentStackView.addArrangedSubview(imageView)
                        
            imageView.snp.makeConstraints { make in
                make.width.equalTo(mainStackView).offset(-PICTURES_PADDING)
                make.height.equalTo(mainStackView).offset(-(Int(PICTURES_PADDING)*2))
            }
            mainScrollView.layoutIfNeeded()
        }
    }
    
    private func layout() {
        addSubview(mainStackView)
        mainScrollView.addSubview(scrollContentStackView)
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainScrollView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
        
        scrollContentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    func configure(withPictures pictures: [Item.Picture]) {
        self.pictures = pictures
        buildAlbum()
    }
}

// MARK: - UISCrollViewDelegate
extension ItemPicturesView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pictureWidth = mainStackView.frame.width
        let currentScrollPosition = scrollView.contentOffset.x
        currentPage = Int(currentScrollPosition / pictureWidth) + 1
    }
}
