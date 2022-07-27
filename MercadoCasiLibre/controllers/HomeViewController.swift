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
    
    private var cancellable: AnyCancellable?

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
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [searchHeaderView, filtersHeaderView, resultTableViewController.view])
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
        self.addChild(resultTableViewController)
        view.addSubview(mainStackView)
        
        resultTableViewController.didMove(toParent: self)
        
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
        
        resultTableViewController.view.snp.makeConstraints { make in
            make.top.equalTo(filtersHeaderView.snp.bottom)
            make.bottom.equalTo(mainStackView.snp.bottom)
            make.leading.equalTo(mainStackView.snp.leading)
            make.trailing.equalTo(mainStackView.snp.trailing)
        }
    }

    private func search(text: String = "", offset: Int = 0) {
        cancellable = WebService().search(q: text, offset: offset)
            .sink {error in
            print(error)
        } receiveValue: {[weak self] search in
            self?.currentSearch = search
            self?.resultTableViewController.totalResults = search.paging.total
            self?.resultTableViewController.setItems(items: search.results, forNewSearch: text != self?.currentSearch.query)
            self?.filtersHeaderView.setResults(numberOfItems: search.paging.total)
        }
    }
    
}

extension HomeViewController: ResultTableControllerDelegate {
    func resultTableControllerLoadMore() {
        search(text: searchHeaderView.searchText, offset: (currentSearch.paging.limit + currentSearch.paging.offset))
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
}



