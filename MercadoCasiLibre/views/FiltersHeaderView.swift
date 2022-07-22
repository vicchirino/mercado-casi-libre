//
//  FiltersHeaderView.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 22/07/2022.
//

import UIKit
import SnapKit


class FiltersHeaderView: UIView {
    
    private lazy var resultsLabel: UILabel = {
        let label = UILabel()
        label.text = "186 resultados"
        return label
    }()
    
    private lazy var arrivesTodayLabel: UILabel = {
        let label = UILabel()
        label.text = "Llegan hoy"
        return label
    }()
    
    private lazy var arrivesTodaySwitch: UISwitch = {
        let switchView = UISwitch()
        return switchView
    }()
    
    private lazy var arrivesTodayStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [arrivesTodayLabel, arrivesTodaySwitch])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var filterLabel: UILabel = {
        let label = UILabel()
        label.text = "Filtrar  \u{2304}"
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [resultsLabel, arrivesTodayStackView, filterLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = .lightText
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addBorder(side: .bottom, thickness: 1, color: .lightGray)
    }
    
    private func layout() {
        addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setResults(numberOfItems: Int) {
        resultsLabel.text = "\(numberOfItems) resultados"
    }
    
}
