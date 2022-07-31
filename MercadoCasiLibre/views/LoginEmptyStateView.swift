//
//  LoginEmptyStateView.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 25/07/2022.
//

import UIKit
import SnapKit

enum EmptyStateType {
    case favorite
    case notification
    
    var title: String {
        switch self {
        case .favorite:
            return "¿Querés ver tus favoritos?"
        case .notification:
            return "¿Querés ver tus notificaciones?"
        }
    }
    
    var imageName: String {
        switch self {
        case .favorite:
            return "favorite_login_empty_state"
        case .notification:
            return "notifications_login_empty_state"
        }
    }
}

protocol LoginEmptyStateDelegate {
    func loginEmptyStateDelegteLoginButtonTapped()
}

class LoginEmptyStateView: UIView {
    
    var delegate: LoginEmptyStateDelegate?
    
    private lazy var emptyStateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "¿Querés ver tus favoritos?"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14.0)
        label.textColor = .darkTextColor
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ingresa a tu cuenta", for: .normal)
        button.backgroundColor = .blueColor
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private lazy var stackViewContainer: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emptyStateImageView, emptyStateLabel, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.layoutMargins = UIEdgeInsets(top: 80, left: 15, bottom: 15, right: 15)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGrayColor
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(stackViewContainer)
        stackViewContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        emptyStateImageView.snp.makeConstraints { make in
            make.height.equalTo(120)
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
    }
    
    func configure(type: EmptyStateType) {
        emptyStateImageView.image = UIImage(named: type.imageName)
        emptyStateLabel.text = type.title
    }
    
    @objc private func loginButtonTapped() {
        delegate?.loginEmptyStateDelegteLoginButtonTapped()
    }
    
}
