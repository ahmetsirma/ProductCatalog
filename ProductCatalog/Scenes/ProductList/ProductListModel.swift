//
//  ProductListModel.swift
//  ProductCatalog
//
//  Created by Ahmet SIRMA on 13.10.2022.
//

import Foundation

struct ProductList: Decodable, Equatable {
    let products: [Product]
}

struct Product: Decodable, Equatable {
    let product_id: String
    let name: String
    let price: Int
    let image: String
}

final class ProductListModel {
    
    func getProductList(completion: @escaping (_ productList: [Product]) -> Void) {
        HttpClient.sendRequest(url: "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/list") { (response: NetworkResponse<ProductList, NetworkError>) in
            switch response {
            case .success(let response):
                print("Response:", response)
                let productList = response.products
                completion(productList)
                Database.clearAll()
                Database.saveProducts(products: productList)
                break
            case .failure(let error):
                let savedProducts = Database.getSavedProduct()
                print(savedProducts)
                print("error:", error.errorMessage)
                completion(savedProducts)
            }
        }
    }
}
