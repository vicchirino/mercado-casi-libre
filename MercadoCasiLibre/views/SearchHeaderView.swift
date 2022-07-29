//
//  SearchHeaderView.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 22/07/2022.
//

import UIKit
import SnapKit
import SwiftIcons

protocol SearchHeaderViewDelegate {
    func searchHeaderViewDidEndSearch(withText text: String)
    func searchHeaderViewBackButtonTapped()
}

class SearchHeaderView: UIView {
    
    var delegate: SearchHeaderViewDelegate?
    var searchText: String {
        get {
            return searchBarView.text ?? ""
        }
    }
    
    private lazy var searchBarView: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Buscar en Mercado Casi Libre"
        searchBar.backgroundColor = .yellowColor
        searchBar.searchBarStyle = .minimal
        searchBar.showsCancelButton = false
        searchBar.delegate = self
        searchBar.searchTextField.delegate = self
        searchBar.tintColor = .darkTextColor
        return searchBar
    }()
    
    private lazy var cartButton: UIButton = {
        let button = UIButton()
        button.setIcon(icon: .linearIcons(.cart), iconSize: 24, color: .darkTextColor, forState: .normal)
        button.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var magnifierButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setIcon(icon: .linearIcons(.magnifier), iconSize: 24, color: .darkTextColor, forState: .normal)
        button.addTarget(self, action: #selector(magnifierButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setIcon(icon: .linearIcons(.arrowLeft), iconSize: 24, color: .darkTextColor, forState: .normal)
        button.alpha = 0
        button.isHidden = true
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [backButton ,searchBarView, magnifierButton, cartButton])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellowColor
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
    
    private func clearSearch() {
        searchBarView.text = nil
        searchBarView.resignFirstResponder()
        magnifierButton.isHidden = false
            searchBarView.alpha = 0
    }
    
    func displayBackButton() {
        backButton.isHidden = false
        backButton.alpha = 1
        clearSearch()
    }
    
    func hideBackButton() {
        backButton.isHidden = true
        backButton.alpha = 0
        UIView.animate(withDuration: 0.0, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
            self.magnifierButton.isHidden = true
            self.searchBarView.alpha = 1
        }, completion: nil)
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
    }
    
    @objc private func magnifierButtonTapped() {
        print("Magnifier button tapped")
    }
    
    @objc private func backButtonTapped() {
        hideBackButton()
        delegate?.searchHeaderViewBackButtonTapped()
    }
}

extension SearchHeaderView: UISearchBarDelegate, UITextFieldDelegate {
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
        
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            delegate?.searchHeaderViewDidEndSearch(withText: text)
        }
        displayCartButton()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
