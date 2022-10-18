//
//  ProductCatalogTests.swift
//  ProductCatalogTests
//
//  Created by AHMET SIRMA on 12.10.2022.
//

import XCTest
@testable import ProductCatalog

final class ProductCatalogTests: XCTestCase {

    private var productListView: ProductListViewControllerTest!
    private var productListViewModel: ProductListViewModel!
    private var productListModel: ProductListModel!
    
    private var productDetailsView: ProductDetailsViewControllerTest!
    private var productDetailsViewModel: ProductDetailsViewModel!
    private var productDetailsModel: ProductDetailsModel!
    
    override func setUp() {
        productListModel = ProductListModel()
        productListViewModel = ProductListViewModel()
        productListView = ProductListViewControllerTest()
        productListViewModel.view = productListView
        
        productDetailsModel = ProductDetailsModel()
        productDetailsViewModel = ProductDetailsViewModel()
        productDetailsView = ProductDetailsViewControllerTest()
        productDetailsViewModel.view = productDetailsView
    }
    
    
    //Product List Tests
    class ProductListViewControllerTest: ProductListViewController {
        override func displayProducts(products: [ProductPresentation]) {
            XCTAssertTrue(products.count > 0)
        }
    }
    
    func testProductListLoad() throws {
        productListView.viewDidLoad()
    }
    
    func testProductListNavigation() throws {
        productListViewModel.productSelected(product: ProductPresentation(product_id: "1", name: "Apple", price: 0, image: ""))
    }
    
    
    
    //Product Details Tests
    class ProductDetailsViewControllerTest: ProductDetailsViewController {
        override var productId: String? {
            didSet {
                XCTAssertNotNil(productId)
            }
        }
    }
    
    func testProductDetailsLoad() throws {
        productDetailsView.viewDidLoad()
    }
    
    func testProductDetailsModel() throws {
        let model = ProductDetailsModel()
        model.getProductDetails(productID: "1", completion: { productDetails in
            XCTAssertNotNil(productDetails)
        })
    }
}
