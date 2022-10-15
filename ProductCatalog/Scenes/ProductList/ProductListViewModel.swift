//
//  ProductListViewModel.swift
//  ProductCatalog
//
//  Created by Ahmet SIRMA on 13.10.2022.
//

import Foundation

struct ProductPresentation: Decodable, Equatable {
    let product_id: String
    let name: String
    let price: Int
    let image: String
}

protocol ProductListViewModelProtocol {
    func getProductList()
    func productSelected(product: ProductPresentation)
}

class ProductListViewModel: ProductListViewModelProtocol {
    let model = ProductListModel()
    var view: ProductListViewController? = nil
    let router = ProductListRouter()
    
    func getProductList() {
        //get from model
        model.getProductList { productList in
            let products = productList.map{ProductPresentation( product_id: $0.product_id, name: $0.name, price: $0.price, image: $0.image )}
            self.view?.displayProducts(products: products)
        }
        //call display from view
        return
    }
    
    func productSelected(product: ProductPresentation) {
        router.routeToDetailScreen(productId: product.product_id)
        return
    }
}
