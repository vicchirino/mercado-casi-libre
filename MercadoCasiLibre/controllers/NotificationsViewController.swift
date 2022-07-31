//
//  NotificationsViewController.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 22/07/2022.
//

import UIKit
import Toaster

class NotificationsViewController: UIViewController {
    
    private lazy var loginEmptyStateView: LoginEmptyStateView = {
        let view = LoginEmptyStateView()
        view.delegate = self
        view.configure(type: .notification)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(loginEmptyStateView)
        
        loginEmptyStateView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
}

// MARK: - LoginEmptyStateDelegate
extension NotificationsViewController: LoginEmptyStateDelegate {
    func loginEmptyStateDelegteLoginButtonTapped() {
        Toast(text: CustomError.featureUnavailable.errorDescription).show()
    }
}
