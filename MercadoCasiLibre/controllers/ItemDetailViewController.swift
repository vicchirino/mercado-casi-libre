//
//  ItemDetailViewController.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 28/07/2022.
//

import UIKit
import SnapKit

class ItemDetailViewController: UIViewController {
    
    var item: Item!
    
    private lazy var itemDetailView: ItemDetailView = {
        let view = ItemDetailView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        WebService().getItems(ids: [item.id]) {[weak self] items, error in
            if error != nil {
                // TODO: - Handle error in the UI/UX
                print("Handle error in the UI/UX")
                return
            }
            
            guard let item = items?[0] else {
                // TODO: - Handle error in the UI/UX No results
                print("Handle error in the UI/UX")
                return
            }
            
            self?.itemDetailView.configure(withItem: item)
        }
    }
    
    init(item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
        itemDetailView.configure(withItem: item)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        view.addSubview(itemDetailView)
        
        itemDetailView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
