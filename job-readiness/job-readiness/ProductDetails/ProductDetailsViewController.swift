//
//  ProductDetailsViewController.swift
//  job-readiness
//
//  Created by Bruna Marques De Oliveira Fonseca on 14/09/22.
//

import UIKit

final class ProductDetailsViewController: UIViewController {
    
    var product: ProductDetails?
    var navBarApperance = UINavigationBar()
    var isFavorite = false
    
    private lazy var productImage: UIImageView = {
        let productImage = UIImageView()
        if let product = product {
            productImage.load(url: URL(string: product.body.pictures[0].url)!)
        }
        productImage.translatesAutoresizingMaskIntoConstraints = false
        return productImage
    }()
    
    private lazy var stackViewTop: UIStackView = {
        let stackViewTop = UIStackView()
        stackViewTop.axis = .vertical
        stackViewTop.spacing = 30
        stackViewTop.addArrangedSubview(productTitleLabel)
        stackViewTop.addArrangedSubview(productPriceLabel)
        stackViewTop.translatesAutoresizingMaskIntoConstraints = false
        return stackViewTop
    }()
    
    private lazy var customView: UIView = {
        let customView = UIView()
        
        return customView
    }()
    
    private lazy var productTitleLabel: UILabel = {
        let ProductTitleLabel = UILabel()
        ProductTitleLabel.text = product!.body.title
        ProductTitleLabel.adjustsFontSizeToFitWidth = true
        ProductTitleLabel.numberOfLines = 0
        ProductTitleLabel.textAlignment = .left
        ProductTitleLabel.font = ProductTitleLabel.font.withSize(20)
        ProductTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return ProductTitleLabel
    }()
    
    private lazy var productPriceLabel: UILabel = {
        let productPriceLabel = UILabel()
        productPriceLabel.text = "\(product!.body.currency_id) \(product!.body.price)"
        productPriceLabel.font = UIFont.boldSystemFont(ofSize: 15)
        productPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        return productPriceLabel
    }()
    
    private lazy var purchaseButton: UIButton = {
        let purchaseButton = UIButton()
        purchaseButton.setTitle("Comprar agora", for: .normal)
        purchaseButton.backgroundColor = UIColor(hexaRGBA: "#3483FA")
        purchaseButton.layer.cornerRadius = 4
        purchaseButton.setTitleColor(UIColor.white, for: .normal)
        purchaseButton.addTarget(self, action: #selector(handleTappedButton), for: .touchUpInside)
        purchaseButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        purchaseButton.translatesAutoresizingMaskIntoConstraints = false
        return purchaseButton
    }()
    
    private lazy var addToCartButton: UIButton = {
        let addToCartButton = UIButton()
        addToCartButton.setTitle("Adicionar ao carrinho", for: .normal)
        addToCartButton.backgroundColor = UIColor(hexaRGBA: "#E3EDFB")
        addToCartButton.layer.cornerRadius = 4
        addToCartButton.addTarget(self, action: #selector(handleTappedButton), for: .touchUpInside)
        addToCartButton.setTitleColor(UIColor(hexaRGBA: "#3483FA"), for: .normal)
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        return addToCartButton
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let buttonStackView = UIStackView()
        buttonStackView.axis = .vertical
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 14
        buttonStackView.backgroundColor = .clear
        buttonStackView.addArrangedSubview(purchaseButton)
        buttonStackView.addArrangedSubview(addToCartButton)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        return buttonStackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Detalhes do produto"
        
        addSubviews()
        setUpNavigationBar()
        constraintsProductImage()
        constraintsStackViewTop()
        constraintsButtonsStackView()
    }
    
    convenience init(product: ProductDetails) {
        self.init(nibName: nil, bundle: nil)
        
        self.product = product
    }
    
    private func addSubviews() {
        view.addSubview(productImage)
        view.addSubview(stackViewTop)
        view.addSubview(buttonsStackView)
    }
    
    private func setUpNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        let navBar = navigationController!.navigationBar
        navBar.tintColor = .black
        navBar.backgroundColor = UIColor(hexaRGB: "#FFE600")
        navBar.isTranslucent = false
        navBar.barStyle = .default
                
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.backgroundColor = UIColor(hexaRGBA: "#FFE600")
        navBar.standardAppearance = standardAppearance
        navBar.scrollEdgeAppearance = standardAppearance
        
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: self, action: #selector(addOrRemoveFromFavorite))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    private func constraintsProductImage() {
        let constraints = [
            productImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            productImage.heightAnchor.constraint(equalToConstant: 200),
            productImage.widthAnchor.constraint(equalTo: view.widthAnchor)
        ]
        
        constraints.forEach({ (item) in
            item.isActive = true
        })
    }
    
    private func constraintsStackViewTop() {
        let constraints = [
            stackViewTop.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 60),
            stackViewTop.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            stackViewTop.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ]
        
        constraints.forEach({ (item) in
            item.isActive = true
        })
    }
    
    private func constraintsButtonsStackView() {
        let constraints = [
            buttonsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            buttonsStackView.topAnchor.constraint(equalTo: stackViewTop.bottomAnchor, constant: 20)
        ]
        
        constraints.forEach({ (item) in
            item.isActive = true
        })
    }
    
    @objc private func handleTappedButton() {
        print("You tapped here")
    }
    
    @objc private func addOrRemoveFromFavorite() {
        isFavorite = isFavorite ? false : true
         print(isFavorite)
    }
}
