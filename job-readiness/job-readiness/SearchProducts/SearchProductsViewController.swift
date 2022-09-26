//
//  SearchProductsViewController.swift
//  job-readiness
//
//  Created by Bruna Marques De Oliveira Fonseca on 12/09/22.
//

import UIKit

final class SearchProductsViewController: UIViewController {
    
    let service = ProductsService()
    var products = [ProductDetails]()
    var filteredProducts = Array<ProductDetails>()
    
    private lazy var screenTitle: UILabel = {
        let screenTitle = UILabel()
        screenTitle.text = "Top 20 da categoria"
        screenTitle.font = UIFont.boldSystemFont(ofSize: 15)
        screenTitle.translatesAutoresizingMaskIntoConstraints = false
        return screenTitle
    }()
    
    private lazy var searchBar: UITextField = {
        let searchBar = UITextField()
        searchBar.placeholder = "buscar produtos"
        searchBar.borderStyle = .line
        searchBar.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var stackViewTop: UIStackView = {
        let stackViewTop = UIStackView()
        stackViewTop.axis = .vertical
        stackViewTop.backgroundColor = UIColor(hexaRGB: "#FFE600")
        stackViewTop.addSubview(searchBar)
        stackViewTop.addSubview(screenTitle)
        stackViewTop.translatesAutoresizingMaskIntoConstraints = false
        return stackViewTop
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
        tableView.rowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        service.serviceDelegate = self
        service.getCategotyId()
        
        addSubviews()
        constraintsSearhcBar()
        constraintsStackViewTop()
        constraintsScreenTitle()
        constraintsTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(stackViewTop)
    }
    
    private func constraintsTableView() {
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 36).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
    }
    
    private func constraintsStackViewTop() {
        let constraints = [
            stackViewTop.widthAnchor.constraint(equalTo: view.widthAnchor),
            stackViewTop.heightAnchor.constraint(equalToConstant: 280),
            stackViewTop.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 0),
        ]
        
        constraints.forEach({ (item) in
            item.isActive = true
        })
    }
    
    private func constraintsScreenTitle() {
        let constraints = [
            screenTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            screenTitle.topAnchor.constraint(equalTo: searchBar.topAnchor, constant: -30)
        ]
        
        constraints.forEach({ (item) in
            item.isActive = true
        })
    }
    
    private func constraintsSearhcBar() {
        let constraints = [
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        constraints.forEach({ (item) in
            item.isActive = true
        })
    }
    
    @objc private func textFieldDidChange(textField: UITextField) {
        guard let textField = textField.text else { return }
        if textField == "" {
            filteredProducts = products
        } else {
            filteredProducts = products.filter({ $0.body.title.lowercased().contains(textField.lowercased())
            })
        }
        
        self.tableView.reloadData()
    }
    
    private func pushToProductsDetails(product: ProductDetails) {
        let viewController = ProductDetailsViewController(product: product)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension SearchProductsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = filteredProducts[indexPath.row]
        pushToProductsDetails(product: product)
    }
}

extension SearchProductsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier) as! ProductTableViewCell
        cell.setElements(product: filteredProducts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
}

extension SearchProductsViewController: ServiceDelegate {
    func updateTableVieW() {
        DispatchQueue.main.async {
            self.products = self.service.products
            self.filteredProducts = self.products

            self.tableView.reloadData()
        }
    }
    
    
}
