//
//  ResultTableController.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 21/07/2022.
//

import UIKit
import SnapKit

struct Item {
    var title: String
    var price: String
}

class ItemTableViewCell: UITableViewCell {
    
    static var identifier: String = "ItemTableViewCell"
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .red
        return label
    }()

    private lazy var price: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .orange
        return label
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [title, price])
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(containerStackView)
        
        containerStackView.snp.makeConstraints { make in
            make.edges.equalTo(self.snp.edges)
        }
        
        title.snp.makeConstraints { make in
            make.trailing.equalTo(containerStackView.snp.trailing)
            make.leading.equalTo(containerStackView.snp.leading)
            make.top.equalTo(containerStackView.snp.top)
        }
    }
    
    func configureCell(item: Item) {
        title.text = item.title
        price.text = item.price
    }
    
}


class ResultTableController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.identifier)
        self.view.backgroundColor = .purple
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ItemTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as? ItemTableViewCell else {
            fatalError("Failed to get expected kind of reusable cell from the tableView. Expected type `ItemTableViewCell`")
        }
        
        let item: Item = Item(title: "Item numero \(indexPath.row)", price: "\(indexPath.row * 2)")
        cell.configureCell(item: item)
        return cell
    }
    
    
}
