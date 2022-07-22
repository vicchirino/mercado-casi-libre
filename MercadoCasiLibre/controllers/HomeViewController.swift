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
    
    private lazy var searchHeaderView: SearchHeaderView = {
        let view = SearchHeaderView()
        return view
    }()
    
    private lazy var filtersHeaderView: FiltersHeaderView = {
        let view = FiltersHeaderView()
        return view
    }()
    
    private lazy var resultTableViewController: ResultTableController = {
        let tableViewController = ResultTableController()
        return tableViewController
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [searchHeaderView, filtersHeaderView, resultTableViewController.view])
        stackView.axis = .vertical
        return stackView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        search()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupViews() {
        view.backgroundColor = .systemYellow
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

    private func search() {
        cancellable =  APIClient().getSearchWithCombine(q: "apple")
            .receive(on: DispatchQueue.main)
            .sink {[weak self] result in
                switch result {
                case .success(let search):
                    self?.resultTableViewController.setItems(items: search.results)
                    self?.filtersHeaderView.setResults(numberOfItems: search.results.count)
                case .failure(let error):
                    fatalError("Error when searching \(error)")
                }
            }
    }
    
}

