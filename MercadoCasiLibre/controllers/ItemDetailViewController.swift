//
//  ItemDetailViewController.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 28/07/2022.
//

import UIKit
import SnapKit
import Toaster

class ItemDetailViewController: UIViewController {
    
    var item: Item!
    
    private lazy var itemDetailView: ItemDetailView = {
        let view = ItemDetailView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        fetchItemDetails()
    }
    
    private func fetchItemDetails() {
        WebService().getItems(ids: [item.id]) {[weak self] items, error in
            if error != nil {
                Toast(text: error?.errorDescription).show()
                return
            }
            guard let item = items?[0] else {
                Toast(text: CustomError.notFound.errorDescription).show()
                return
            }
            self?.itemDetailView.configure(withItem: item)
        }
        // FIXME: ¿Por qué un endpoint aparte para obtener la descripcion del item?
        WebService().getItemsDescription(ids: [item.id]) { [weak self] itemsDescription, error in
            if error != nil {
                Toast(text: error?.errorDescription).show()
                return
            }
            guard let descriptions = itemsDescription else {
                Toast(text: CustomError.notFound.errorDescription).show()
                return
            }
            self?.itemDetailView.setItemDescription(text: descriptions.text)
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
