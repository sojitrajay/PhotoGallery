//
//  CoreDataManager.swift
//  PhotoGallery
//
//  Created by Jayesh Sojitra on 05/09/17.
//  Copyright © 2017 Jayesh Sojitra. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {

    var managedObjContext: NSManagedObjectContext!
 
    func saveImageData(data : [String:Any]) {
        
        let arrayImage = data["images"] as? [AnyObject] ?? []
        
        for item in arrayImage
        {
            let imageId = item["id"] as? Int ?? 0
            
            let currentImageName = item["large_url"] as? String ?? ""
            
            let managedObjPackage = self.managedObjContext.insertInto(entity: String(describing: CategoryImage.self), AgainstConditions: "id = %d", Arguments: imageId) as! CategoryImage
            managedObjPackage.mapValuesFrom(data: item as? [String : AnyObject] ?? [:])
            
            print(currentImageName)
        }
        
        print("Saved data successfully : \(self.managedObjContext.commit())")

    }
    
    func getAllImages() -> [CategoryImage] {
        
        return self.managedObjContext.getAllDataFor(entity: String(describing: CategoryImage.self)) as? [CategoryImage] ?? []
        
    }
    
}
