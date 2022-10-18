//
//  Database.swift
//  ProductCatalog
//
//  Created by Ahmet SIRMA on 17.10.2022.
//

import Foundation
import CoreData
import UIKit

final class Database {
    
    static func clearAll() {
        DispatchQueue.main.async {
            do {
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                    return
                }
                let context = appDelegate.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductEntity")
                let fetchedObjects = try context.fetch(fetchRequest) as? [NSManagedObject] ?? []
                for object in fetchedObjects {
                    context.delete(object)
                }
            }
            catch let err {
                print(err)
            }
        }
        
        
    }
    
    static func saveProducts(products: [Product]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "ProductEntity", in: context) else { return }
        
        for product in products {
            let item = NSManagedObject(entity: entity, insertInto: context)
            item.setValue(product.product_id, forKey: "product_id")
            item.setValue(product.name, forKey: "name")
            item.setValue(product.price, forKey: "price")
            item.setValue(product.image, forKey: "image")
            
            do {
                try context.save()
            }
            catch let err {
                print(err)
            }
        }
    }
    
    static func getSavedProduct() -> [Product] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductEntity")
        do {
            let results = try context.fetch(fetchRequest)
            //let obj = (results.first as! NSManagedObject)
            var products = [Product]()
            for item in results as! [NSManagedObject] {
                let product = Product(product_id: item.value(forKey: "product_id") as! String, name: item.value(forKey: "name") as! String, price: item.value(forKey: "price") as! Int, image: item.value(forKey: "image") as! String)
                products.append(product)
            }
            return products
        }
        catch let err {
            print(err)
            return []
        }
    }
}
