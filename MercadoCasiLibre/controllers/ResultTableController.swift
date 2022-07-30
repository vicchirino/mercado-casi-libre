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
    func resultTableControllerItemDidSelected(item: Item)
}

class ResultTableController: UITableViewController {
    
//    private var items: [Item] = []
    private var currentSearch: Search = Search.placeHolder()
    
    var delegate: ResultTableControllerDelegate?
    var totalResults: Int = 0
    
    private var query: String = ""
    
    private var isLoading: Bool = false
    
    private lazy var emptyStateView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGrayColor
        return view
    }()
    
    private lazy var emptyStateText: UILabel = {
        let label = UILabel()
        label.text = "No hay resultados. Usa el buscador"
        label.numberOfLines = 3
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 22.0)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.identifier)
        tableView.register(LoadMoreTableViewCell.self, forCellReuseIdentifier: LoadMoreTableViewCell.identifier)
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupViews() {
        tableView.separatorColor = .lightGrayColor
        emptyStateView.addSubview(emptyStateText)
    }
    
    func setSearch(search: Search) {
        let newPage = search.query == self.currentSearch.query
        var currentResults = self.currentSearch.results
        if search.results.count == 0 {
            emptyStateText.text = search.query == nil ?
                "No hay resultados. Usa el buscador"
            : search.query != self.currentSearch.query ?
                "No hay resultados para '\(search.query ?? "")'"
            : "Usa el buscador para obtener resultados"
        }
        
        self.currentSearch = search
        
        if newPage {
            currentResults.append(contentsOf: self.currentSearch.results)
            self.currentSearch.results = currentResults
        }
        totalResults = self.currentSearch.paging.total
        tableView.reloadData()
    }
    
    private func setEmptyStateView() {
        tableView.backgroundView = emptyStateView
            
        emptyStateText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.lessThanOrEqualToSuperview().offset(-80)
        }
    }
    
    private func removeEmptyStateView() {
        tableView.backgroundView = nil
    }
    
}
// MARK: - UITableViewDelegate, UITableViewDataSource
extension ResultTableController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = currentSearch.results.count
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
        if indexPath.row == currentSearch.results.count {
            return 40
        } else {
            return 170
        }
    }
            
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if row == currentSearch.results.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LoadMoreTableViewCell.identifier, for: indexPath) as? LoadMoreTableViewCell else {
                fatalError("Failed to get expected kind of reusable cell from the tableView. Expected type `LoadMoreTableViewCell`")
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as? ItemTableViewCell else {
                fatalError("Failed to get expected kind of reusable cell from the tableView. Expected type `ItemTableViewCell`")
            }
            cell.configureCell(item: currentSearch.results[row])
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        if row == currentSearch.results.count {
            // The LoadMoreTableViewCell was pressed. Do nothing.
            return
        }
        let item = currentSearch.results[row]
        let itemDetailViewController = ItemDetailViewController(item: item)
        
        delegate?.resultTableControllerItemDidSelected(item: item)
        navigationController?.pushViewController(itemDetailViewController, animated: true)
    }
}



