//
//  ViewController.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 20/07/2022.
//

import UIKit
import SnapKit
import Combine
import Toaster

class HomeViewController: UIViewController {
    
    private var currentSearch: Search!
    
    private lazy var searchHeaderView: SearchHeaderView = {
        let view = SearchHeaderView()
        view.delegate = self
        return view
    }()
    
    private lazy var filtersHeaderView: FiltersHeaderView = {
        let view = FiltersHeaderView()
        view.delegate = self
        return view
    }()
    
    private lazy var resultTableViewController: ResultTableController = {
        let tableViewController = ResultTableController()
        tableViewController.delegate = self
        return tableViewController
    }()
    
    private lazy var resultNavigationController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: resultTableViewController)
        return navigationController
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [searchHeaderView, filtersHeaderView, resultNavigationController.view])
        stackView.axis = .vertical
        return stackView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        search()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupViews() {
        view.backgroundColor = .yellowColor
        self.addChild(resultNavigationController)
        view.addSubview(mainStackView)
        
        resultNavigationController.didMove(toParent: self)
                
        mainStackView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        
        searchHeaderView.snp.makeConstraints { make in
            make.top.equalTo(mainStackView.snp.top)
            make.leading.equalTo(mainStackView.snp.leading)
            make.trailing.equalTo(mainStackView.snp.trailing)
            make.height.equalTo(60)
        }
        
        filtersHeaderView.snp.makeConstraints { make in
            make.leading.equalTo(mainStackView.snp.leading)
            make.trailing.equalTo(mainStackView.snp.trailing)
            make.height.equalTo(45)
        }
        
        resultNavigationController.view.snp.makeConstraints { make in
            make.top.equalTo(filtersHeaderView.snp.bottom)
            make.bottom.equalTo(mainStackView.snp.bottom)
            make.leading.equalTo(mainStackView.snp.leading)
            make.trailing.equalTo(mainStackView.snp.trailing)
        }
    }

    private func search(text: String = "", offset: Int = 0) {
        WebService().search(q: text, offset: offset) {[weak self] search, error in
            if error != nil {
                // TODO: - Handle error in the UI/UX
                Toast(text: error?.errorDescription).show()
            } else {
                self?.resultTableViewController.setSearch(search: search)
                self?.filtersHeaderView.setResults(numberOfItems: search.paging.total)
            }
            self?.currentSearch = search
        }
    }
    
}

extension HomeViewController: ResultTableControllerDelegate {
    func resultTableControllerLoadMore() {
        search(text: currentSearch.query ?? searchHeaderView.searchText, offset: (currentSearch.paging.limit + currentSearch.paging.offset))
    }
    
    func resultTableControllerItemDidSelected(item: Item) {
        // TODO: - Move this transition to other place.
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut, animations: {
            self.filtersHeaderView.snp.remakeConstraints { [weak self] make in
                make.leading.equalTo(self?.mainStackView.snp.leading ?? 0)
                make.trailing.equalTo(self?.mainStackView.snp.trailing ?? 0)
                make.height.equalTo(0)
            }
            self.mainStackView.layoutIfNeeded()
        }, completion: { _ in
            self.filtersHeaderView.isHidden = true
            self.searchHeaderView.displayBackButton()
        })
    }
}

extension HomeViewController: FiltersHeaderViewDelegate {
    func filtersHeaderViewArrivesTodayChanged(toValue value: Bool) {
        print("Delegate called")
    }
}

extension HomeViewController: SearchHeaderViewDelegate {
    func searchHeaderViewDidEndSearch(withText text: String) {
        search(text: text, offset: 0)
    }
    
    func searchHeaderViewCartButtonTapped() {
        Toast(text: CustomError.featureUnavailable.errorDescription).show()
    }
    
    func searchHeaderViewBackButtonTapped() {
        // TODO: - Move this transition to other place.
        resultNavigationController.popToRootViewController(animated: true)
        UIView.animate(withDuration: 0.15, delay: 0.15, options: .curveEaseInOut, animations: {
            self.filtersHeaderView.isHidden = false
            self.filtersHeaderView.snp.remakeConstraints { [weak self] make in
                make.leading.equalTo(self?.mainStackView.snp.leading ?? 0)
                make.trailing.equalTo(self?.mainStackView.snp.trailing ?? 0)
                make.height.equalTo(45)
            }
            self.mainStackView.layoutIfNeeded()
        }, completion: nil)
    }
}



