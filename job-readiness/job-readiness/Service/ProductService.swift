//
//  Service.swift
//  job-readiness
//
//  Created by Bruna Marques De Oliveira Fonseca on 13/09/22.
//

import Foundation

protocol ServiceDelegate {
    func updateTableVieW()
}

class ProductsService {
    static let baseUrl = "https://api.mercadolibre.com"
    static let token = "Bearer APP_USR-6984248548720076-091913-3a9453d0308f6215683cf87bdcfd5cfc-1168957761"
    
     var products = [ProductDetails]()
     var serviceDelegate: ServiceDelegate?
    
    func getCategotyId() {
        let url = URL(string: "\(ProductsService.baseUrl)/sites/MLB/domain_discovery/search?limit=1&q=acessorios")
        
        guard let url = url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(ProductsService.token, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let categoryId = try JSONDecoder().decode([CategoryId].self, from: data)
//                print(categoryId[0].category_id)
                self.getProductsId(categoryId: categoryId[0].category_id)
            } catch let error {
                print("error: \(error)")
            }
        }
        task.resume()
    }
    
    func getProductsId(categoryId: String) {
        let url = URL(string: "\(ProductsService.baseUrl)/highlights/MLB/category/\(categoryId)")
        
        guard let url = url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(ProductsService.token, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let productContent = try JSONDecoder().decode(ProductContent.self, from: data)
//                print(productContent)
                let productsIds = productContent.content.map({ $0.id })
//                print(productsIds)
                self.getProductsDetails(ids: productsIds)
            } catch let error {
                print("error: \(error.localizedDescription)")
                print("error: \(error)")

            }
        }
        task.resume()
    }
    
    func getProductsDetails(ids: [String]) {
        var stringsOfIds = ""
        ids.forEach({ (item) in
            stringsOfIds += "\(item),"
        })
        
        let url = URL(string: "\(ProductsService.baseUrl)/items?ids=\(stringsOfIds)")
        guard let url = url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(ProductsService.token, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
//            print(String(data: data, encoding: .utf8))
            do {
                let productsDetails  = try JSONDecoder().decode([ProductDetails].self, from: data)
                self.products = productsDetails
                self.serviceDelegate?.updateTableVieW()
//                print(productsDetails[0].body.title)
            } catch let error {
                print("error: \(error)")
                print("error: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
}
