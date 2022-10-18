//
//  ProductDetailsViewController.swift
//  ProductCatalog
//
//  Created by Ahmet SIRMA on 13.10.2022.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    var productDetails: ProductDetailsPresentation?
    let viewModel = ProductDetailsViewModel()
    var productId: String? {
        didSet {
            if productId != nil {
                viewModel.view = self
                self.indLoading?.startAnimating()
                viewModel.getProductDetails(productId: productId!)
            }
        }
    }
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var indLoading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var lblDescription: UILabel!
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func displayProduct(product: ProductDetailsPresentation?) {
        if let prod = product {
            self.productDetails = prod
            let text = (self.productDetails?.name ?? "") + "\n" + (self.productDetails?.description ?? "")
            
            DispatchQueue.main.async {
                self.lblDescription.text = text
                self.lblDescription.sizeToFit()
                self.indLoading.stopAnimating()
            }
            
            UIImage.loadCachedImage(urlStr: self.productDetails!.image) { img in
                DispatchQueue.main.async {
                    self.imgPoster.image = img
                }
            }
        }
        
        return
    }

}
