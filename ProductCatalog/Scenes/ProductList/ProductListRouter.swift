//
//  ProductListRouter.swift
//  ProductCatalog
//
//  Created by Ahmet SIRMA on 13.10.2022.
//

import Foundation


protocol ProductListRouterProtocol {
    func routeToDetailScreen(productId: String)
}


class ProductListRouter: ProductListRouterProtocol {
    func routeToDetailScreen(productId: String) {
        let detailScreen = ProductDetailsViewController()
        detailScreen.productId = productId
        AppDelegate.navigationController()?.pushViewController(detailScreen, animated: true)
        return
    }
}
