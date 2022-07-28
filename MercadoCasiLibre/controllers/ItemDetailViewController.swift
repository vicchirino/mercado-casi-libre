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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        print("Item name: \(item.title)")
    }
    
    init(item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
