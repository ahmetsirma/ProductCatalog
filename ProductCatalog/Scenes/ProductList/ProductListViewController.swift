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
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ProductCollectionCell")
        
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.reloadData()
    }
}

extension ProductListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.productSelected(product: self.productList[indexPath.row])
    }
}

extension ProductListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionCell", for: indexPath)
        let product = self.productList[indexPath.row]
        for subview in cell.subviews {
            subview.removeFromSuperview()
        }
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        
        let imgPoster = UIImageView()
        UIImage.loadCachedImage(urlStr: product.image) { img in
            DispatchQueue.main.async {
                imgPoster.image = img
            }
        }
        
        
        imgPoster.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height - 60)
        cell.addSubview(imgPoster)
        
        let titleLabel = UILabel()
        titleLabel.text = product.name
        titleLabel.textColor = .white
        titleLabel.backgroundColor = .gray
        titleLabel.frame = CGRect(x: 5, y: cell.frame.height - 50, width: cell.frame.width - 10, height: 40)
        titleLabel.textAlignment = .center
        cell.addSubview(titleLabel)
        
        return cell
    }
}

extension ProductListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.collectionView.frame.width / 3 - 10
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
}
