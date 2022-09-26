//
//  ProductDetails.swift
//  job-readiness
//
//  Created by Bruna Marques De Oliveira Fonseca on 14/09/22.
//

import Foundation

struct Picture: Codable {
    let id: String
    let url: String
}

struct Detail: Codable {
    let id: String
    let title: String
    let price: Double
    let currency_id: String
    let sold_quantity: Int
    let pictures: [Picture]
}

struct ProductDetails: Codable {
    let body: Detail
}
