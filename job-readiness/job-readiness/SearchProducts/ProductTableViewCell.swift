//
//  ProductCell.swift
//  job-readiness
//
//  Created by Bruna Marques De Oliveira Fonseca on 12/09/22.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    static let identifier: String = "ProductTableViewCell"
    
    private lazy var productNameLabel: UILabel = {
        let productNameLabel = UILabel()
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        productNameLabel.numberOfLines = 2
        productNameLabel.font = productNameLabel.font.withSize(18)
        productNameLabel.adjustsFontSizeToFitWidth = true
        productNameLabel.textAlignment = .center
        return productNameLabel
    }()
    
    private lazy var productPriceLabel: UILabel = {
        let productPriceLabel = UILabel()
        productPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        productPriceLabel.numberOfLines = 0
        productPriceLabel.font = productPriceLabel.font.withSize(10)
        productPriceLabel.adjustsFontSizeToFitWidth = true
        productPriceLabel.textAlignment = .center
        return productPriceLabel
    }()
        
    private lazy var productImage: UIImageView = {
        let productImage = UIImageView()
        productImage.translatesAutoresizingMaskIntoConstraints = false
        return productImage
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        productNameLabelConstraints()
        productImageConstraints()
        productPriceLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addSubviews() {
        addSubview(productNameLabel)
        addSubview(productImage)
        addSubview(productPriceLabel)
    }
    
    private func productNameLabelConstraints() {
        let constraints = [
            productNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            productNameLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 20),
            productNameLabel.heightAnchor.constraint(equalToConstant: 80),
            productNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ]
        
        constraints.forEach({ (item) in
            item.isActive = true
        })
    }
    
    private func productPriceLabelConstraints() {
        let constraints = [
            productPriceLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 20),
            productPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: -16)
        ]
        
        constraints.forEach({ (item) in
            item.isActive = true
        })
    }
    
    private func productImageConstraints() {
        let constraints = [
            productImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            productImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            productImage.heightAnchor.constraint(equalToConstant: 80),
            productImage.widthAnchor.constraint(equalToConstant: 80)
        ]
        
        constraints.forEach({ (item) in
            item.isActive = true
        })
    }
    
    func setElements(product: ProductDetails) {
        productNameLabel.text = product.body.title
        productPriceLabel.text = "\(product.body.currency_id) \(product.body.price)"
        productImage.load(url: URL(string: product.body.pictures[0].url)!)
    }
}

