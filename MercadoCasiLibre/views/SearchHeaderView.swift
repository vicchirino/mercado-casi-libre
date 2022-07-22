//
//  SearchHeaderView.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 22/07/2022.
//

import UIKit
import SnapKit
import SwiftIcons

class SearchHeaderView: UIView {
    
    private lazy var searchBarView: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Buscar en Mercado Casi Libre"
        searchBar.backgroundColor = .systemYellow
        searchBar.searchBarStyle = .minimal
        searchBar.showsCancelButton = false
        searchBar.delegate = self
        searchBar.tintColor = .darkGray
        return searchBar
    }()
    
    private lazy var cartButton: UIButton = {
        let button = UIButton()
        button.setIcon(icon: .linearIcons(.cart), iconSize: 24, color: .darkGray, forState: .normal)
        button.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setIcon(icon: .linearIcons(.arrowLeft), iconSize: 24, color: .darkGray, forState: .normal)
        button.alpha = 0
        button.isHidden = true
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [backButton ,searchBarView, cartButton])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemYellow
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func displayBackButton() {
        backButton.isHidden = false
        backButton.alpha = 1
    }
    
    func hideBackButton() {
        backButton.isHidden = true
        backButton.alpha = 0
    }
    
    func displayCartButton() {
        cartButton.isHidden = false
        cartButton.alpha = 1
        searchBarView.showsCancelButton = false
    }
    
    func hideCartButton() {
        cartButton.isHidden = true
        cartButton.alpha = 0
        searchBarView.showsCancelButton = true
    }
    
    @objc private func cartButtonTapped() {
        print("Cart button tapped")
        displayBackButton()
    }
    
    @objc private func backButtonTapped() {
        print("Back button tapped")
        hideBackButton()
    }
}

extension SearchHeaderView: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        hideCartButton()
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        displayCartButton()
        return true
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        displayCartButton()
    }
    
    
}
