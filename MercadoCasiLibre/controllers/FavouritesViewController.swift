//
//  FavouritesViewController.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 22/07/2022.
//

import UIKit
import SnapKit

class FavouritesViewController: UIViewController {
    
    private lazy var loginEmptyStateView: LoginEmptyStateView = {
        let view = LoginEmptyStateView()
        view.configure(type: .favorite)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(loginEmptyStateView)
        
        loginEmptyStateView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
}
