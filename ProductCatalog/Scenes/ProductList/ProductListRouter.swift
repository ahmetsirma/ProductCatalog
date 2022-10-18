//
//  ProductListRouter.swift
//  ProductCatalog
//
//  Created by Ahmet SIRMA on 13.10.2022.
//

import Foundation
import UIKit


protocol ProductListRouterProtocol {
    func routeToDetailScreen(productId: String)
}


final class ProductListRouter: ProductListRouterProtocol {
    func routeToDetailScreen(productId: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let detailScreen = storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        AppDelegate.navigationController()?.pushViewController(detailScreen, animated: true)
        detailScreen.productId = productId
        return
    }
}
