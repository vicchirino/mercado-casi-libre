//
//  FiltersHeaderView.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 22/07/2022.
//

import UIKit
import SnapKit
import SwiftIcons

class FiltersHeaderView: UIView {
    
    private lazy var resultsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var arrivesTodayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
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
        label.text = "Filtrar"
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    private lazy var filterIcon: UIImageView = {
        let view = UIImageView()
        view.setIcon(icon: .linearIcons(.chevronDown), textColor: .systemBlue, backgroundColor: .clear, size: CGSize(width: 18, height: 20))
        return view
    }()
    
    private lazy var filterButtonView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [filterLabel, filterIcon])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        stackView.isLayoutMarginsRelativeArrangement = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(filterButtonTapped))
        stackView.addGestureRecognizer(tapGestureRecognizer)
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [resultsLabel, arrivesTodayStackView, filterButtonView])
        stackView.axis = .horizontal
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
        
        resultsLabel.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(mainStackView.snp.width).multipliedBy(0.35)
        }
        arrivesTodayStackView.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(mainStackView.snp.width).multipliedBy(0.28)
        }
        filterButtonView.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(mainStackView.snp.width).multipliedBy(0.20)
        }
        
    }
    
    func setResults(numberOfItems: Int) {
        resultsLabel.text = "\(numberOfItems) resultados"
    }
    
    @objc func filterButtonTapped() {
        print("Filter button tapped")
    }
    
}
