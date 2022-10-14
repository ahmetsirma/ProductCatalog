//
//  Extensions.swift
//  ProductCatalog
//
//  Created by Ahmet SIRMA on 14.10.2022.
//

import Foundation
import UIKit

extension UIImage {
    static let imageCache = NSCache<AnyObject, AnyObject>()
    
    static func loadCachedImage1(urlStr: String, completion: @escaping (_ image1: UIImage) -> Void ) {
        
        if let cachedImage = UIImage.imageCache.object(forKey: urlStr as AnyObject) as? UIImage {
            completion(cachedImage)
        }
        
        HttpClient.sendDataRequest(url: urlStr) { (response: NetworkResponse<Data, NetworkError>) in
            switch response {
            case .success(let response):
                print("Response:", response)
                if let image = UIImage(data: response) {
                    completion(image)
                }
                else {
                    completion(UIImage(named: "NotFoundImage")!)
                }
            case .failure(let error):
                print("error:", error.errorMessage)
                completion(UIImage(named: "NotFoundImage")!)
            }
        }
    }
}
