//
//  ResultTableController.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 21/07/2022.
//

import UIKit
import SnapKit

protocol ResultTableControllerDelegate {
    func resultTableControllerLoadMore()
}

class ResultTableController: UITableViewController {
    
    @Published private var items: [Item] = []

    var delegate: ResultTableControllerDelegate?
    
    var totalResults: Int = 0
    
    private lazy var emptyStateView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGrayColor
        return view
    }()
    
    private lazy var emptyStateText: UILabel = {
        let label = UILabel()
        label.text = "Usa el buscador para obtener resultados"
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 18.0)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.identifier)
        tableView.register(LoadMoreTableViewCell.self, forCellReuseIdentifier: LoadMoreTableViewCell.identifier)
        setupViews()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = items.count
        if rows == 0 {
            setEmptyStateView()
        } else {
            removeEmptyStateView()
        }
        if rows < totalResults {
            rows += 1 // Include load more results cell
        }
        return rows
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == items.count {
            return 40
        } else {
            return 170
        }
    }
            
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if row == items.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LoadMoreTableViewCell.identifier, for: indexPath) as? LoadMoreTableViewCell else {
                fatalError("Failed to get expected kind of reusable cell from the tableView. Expected type `LoadMoreTableViewCell`")
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as? ItemTableViewCell else {
                fatalError("Failed to get expected kind of reusable cell from the tableView. Expected type `ItemTableViewCell`")
            }
            cell.configureCell(item: items[row])
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let loadMoreTableViewCell = cell as? LoadMoreTableViewCell else {
            return
        }
        loadMoreTableViewCell.startActivityIndicator()
        delegate?.resultTableControllerLoadMore()
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let loadMoreTableViewCell = cell as? LoadMoreTableViewCell else {
            return
        }
        loadMoreTableViewCell.stopActivityIndicator()
    }
    
    private func setupViews() {
        tableView.separatorColor = .lightGrayColor
        emptyStateView.addSubview(emptyStateText)
    }
    
    func setItems(items: [Item], forNewSearch: Bool = false) {
        if forNewSearch {
            self.items = items
        } else {
            self.items.append(contentsOf: items)
        }
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


