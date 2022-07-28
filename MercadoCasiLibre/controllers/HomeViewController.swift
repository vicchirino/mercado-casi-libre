//
//  ViewController.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 20/07/2022.
//

import UIKit
import SnapKit
import Combine

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
                print("Handle Error in UX")
                return
            }
            self?.resultTableViewController.totalResults = search.paging.total
            self?.resultTableViewController.setItems(
                items: search.results,
                forNewSearch: text != self?.currentSearch?.query ?? "")
            self?.filtersHeaderView.setResults(numberOfItems: search.paging.total)
            self?.currentSearch = search
        }
    }
    
}

extension HomeViewController: ResultTableControllerDelegate {
    func resultTableControllerLoadMore() {
        search(text: searchHeaderView.searchText, offset: (currentSearch.paging.limit + currentSearch.paging.offset))
    }
    
    func resultTableControllerItemDidSelected(item: Item) {
        searchHeaderView.displayBackButton()
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
    
    func searchHeaderViewBackButtonTapped() {
        resultNavigationController.popToRootViewController(animated: true)
    }
}



