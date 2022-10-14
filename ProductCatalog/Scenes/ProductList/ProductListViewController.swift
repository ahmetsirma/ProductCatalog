//
//  ViewController.swift
//  ProductCatalog
//
//  Created by AHMET SIRMA on 12.10.2022.
//

import UIKit

class ProductListViewController: UIViewController {
    let viewModel = ProductListViewModel()
    var productList: [ProductPresentation] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.viewModel.view = self
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.viewModel.getProductList()
        
        /*let pm = ProductListModel()
        pm.getProductList()
        
        let pd = ProductDetailsModel()
        pd.getProductDetails(productID: "1")*/
    }
    
    
    func displayProducts(products: [ProductPresentation]) {
        self.productList = products
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        return
    }
}

extension ProductListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}

extension ProductListViewController: UICollectionViewDelegate {
    
}
