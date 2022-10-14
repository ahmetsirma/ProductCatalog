//
//  ViewController.swift
//  ProductCatalog
//
//  Created by AHMET SIRMA on 12.10.2022.
//

import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let pm = ProductListModel()
        pm.getProductList()
        
        let pd = ProductDetailsModel()
        pd.getProductDetails(productID: "1")
    }


}

extension ProductListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}

extension ProductListViewController: UICollectionViewDelegate {
    
}
