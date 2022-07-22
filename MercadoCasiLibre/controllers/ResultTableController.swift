//
//  ResultTableController.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 21/07/2022.
//

import UIKit
import SnapKit

class ResultTableController: UITableViewController {
    
    @Published private var items: [Item] = []

    private lazy var emptyStateView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var emptyStateText: UILabel = {
        let label = UILabel()
        label.text = "Use the search bar to get results"
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 18.0)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.count == 0 {
            setEmptyStateView()
        } else {
            removeEmptyStateView()
        }
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
            
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ItemTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as? ItemTableViewCell else {
            fatalError("Failed to get expected kind of reusable cell from the tableView. Expected type `ItemTableViewCell`")
        }
        
        cell.configureCell(item: items[indexPath.row])
        return cell
    }
    
    private func setupViews() {
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.identifier)
        tableView.separatorColor = .lightGray
        emptyStateView.addSubview(emptyStateText)
    }
    
    func setItems(items: [Item]) {
        self.items = items
        tableView.reloadData()
    }
    
}

extension ResultTableController {
    
    func setEmptyStateView() {
        tableView.backgroundView = emptyStateView
        
        emptyStateText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func removeEmptyStateView() {
        tableView.backgroundView = nil
    }
}


