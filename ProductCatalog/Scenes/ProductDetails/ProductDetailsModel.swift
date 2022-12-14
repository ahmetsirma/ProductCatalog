//
//  ProductDetailsModel.swift
//  ProductCatalog
//
//  Created by Ahmet SIRMA on 13.10.2022.
//

import Foundation

struct ProductDetails: Decodable {
    let product_id: String
    let name: String
    let price: Int
    let image: String
    let description: String?
}

final class ProductDetailsModel {
    
    func getProductDetails(productID: String, completion: @escaping (_ productDetails: ProductDetails) -> Void) {
        HttpClient.sendRequest(url: "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/\(productID)/detail") { (response: NetworkResponse<ProductDetails, NetworkError>) in
            switch response {
            case .success(let response):
                print("Response:", response)
                let productDetails = response
                completion(productDetails)
                break
            case .failure(let error):
                print("error:", error.errorMessage)
            }
        }
    }
}
