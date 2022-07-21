//
//  ViewController.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 20/07/2022.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow
        return view
    }()
    
    private lazy var resultTableViewController: ResultTableController = {
        let tableViewController = ResultTableController()
        return tableViewController
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerView, resultTableViewController.view])
        stackView.axis = .vertical
        return stackView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        resultTableViewController.setItems(items: Item.getMockItems())
    }
    
    private func setupViews() {
        view.backgroundColor = .systemYellow
        self.addChild(resultTableViewController)
        view.addSubview(mainStackView)
        
        resultTableViewController.didMove(toParent: self)
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(mainStackView.snp.top)
            make.leading.equalTo(mainStackView.snp.leading)
            make.trailing.equalTo(mainStackView.snp.trailing)
            make.height.equalTo(60)
        }
        
        resultTableViewController.view.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.equalTo(mainStackView.snp.bottom)
            make.leading.equalTo(mainStackView.snp.leading)
            make.trailing.equalTo(mainStackView.snp.trailing)
        }
    }

}

