//
//  CategoryImage+CoreDataClass.swift
//  PhotoGallery
//
//  Created by Jayesh Sojitra on 05/09/17.
//  Copyright © 2017 Jayesh Sojitra. All rights reserved.
//

import Foundation
import CoreData

@objc(CategoryImage)
public class CategoryImage: NSManagedObject {

    func mapValuesFrom(data : [String : AnyObject]){
        
        id = self.evaluate(value: data["id"], forAttributeType: NSAttributeType.integer32AttributeType) as? Int32 ?? 0
        url = self.evaluate(value: data["url"], forAttributeType: NSAttributeType.stringAttributeType) as? String ?? ""
        large_url = self.evaluate(value: data["large_url"], forAttributeType: NSAttributeType.stringAttributeType) as? String ?? ""

    }

}
