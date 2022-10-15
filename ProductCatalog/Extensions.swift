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
    
    static func loadCachedImage(urlStr: String, completion: @escaping (_ img: UIImage) -> Void ) {
        
        if let cachedImage = UIImage.imageCache.object(forKey: urlStr as AnyObject) as? UIImage {
            completion(cachedImage)
            return
        }
        
        HttpClient.sendDataRequest(url: urlStr) { (response: NetworkResponse<Data, NetworkError>) in
            switch response {
            case .success(let response):
                print("Response:", response)
                if let image = UIImage(data: response) {
                    imageCache.setObject(image as AnyObject, forKey: urlStr as AnyObject)
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
