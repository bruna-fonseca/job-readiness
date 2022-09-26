//
//  FavoriteProductsController.swift
//  job-readiness
//
//  Created by Bruna Marques De Oliveira Fonseca on 16/09/22.
//

import UIKit

final class FavoriteProductsViewController: UIViewController {
    
    private lazy var interjectionLabel: UILabel = {
        let interjectionLabel = UILabel()
        interjectionLabel.text = "Ops!"
        interjectionLabel.numberOfLines = 0
        interjectionLabel.font = UIFont.boldSystemFont(ofSize: 28)
        interjectionLabel.textColor = .black
        interjectionLabel.translatesAutoresizingMaskIntoConstraints =  false
        return interjectionLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Tela em construção"
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = descriptionLabel.font.withSize(20)
        descriptionLabel.textColor = .black
        descriptionLabel.translatesAutoresizingMaskIntoConstraints =  false
        return descriptionLabel
    }()
    
    private lazy var warningStackView: UIStackView = {
        let warningStackView = UIStackView()
        warningStackView.axis = .vertical
        warningStackView.alignment = .center
        warningStackView.spacing = 15
        warningStackView.addArrangedSubview(interjectionLabel)
        warningStackView.addArrangedSubview(descriptionLabel)
        warningStackView.translatesAutoresizingMaskIntoConstraints = false
        return warningStackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexaRGB: "#FFE600")
        
        view.addSubview(warningStackView)
        constraintsWarningStackView()
    }
    
    private func constraintsWarningStackView() {
        let constraints = [
            warningStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            warningStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ]
        
        constraints.forEach({ (item) in
            item.isActive = true
        })
    }
}
