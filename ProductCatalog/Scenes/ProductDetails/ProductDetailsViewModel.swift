//
//  ProductDetailsViewModel.swift
//  ProductCatalog
//
//  Created by Ahmet SIRMA on 13.10.2022.
//

import Foundation

struct ProductDetailsPresentation: Decodable {
    let product_id: String
    let name: String
    let price: Int
    let image: String
    let description: String?
}

protocol ProductDetailsViewModelProtocol {
    func getProductDetails(productId: String)
}

class ProductDetailsViewModel: ProductDetailsViewModelProtocol {
    let model = ProductDetailsModel()
    var view:ProductDetailsViewController?
    
    func getProductDetails(productId: String) {
        model.getProductDetails(productID: productId) { productDetails in
            let detailsPresentation = ProductDetailsPresentation( product_id: productDetails.product_id, name: productDetails.name, price: productDetails.price, image: productDetails.image, description: productDetails.description )
            self.view?.displayProduct(product: detailsPresentation)
        }
    }
}
