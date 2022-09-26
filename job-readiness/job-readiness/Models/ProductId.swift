//
//  ProductId.swift
//  job-readiness
//
//  Created by Bruna Marques De Oliveira Fonseca on 14/09/22.
//

import Foundation

struct ProductItem: Codable {
    let id: String
    let position: Int
    let type: String
}

struct ProductContent: Codable {
    let content: [ProductItem]
}
