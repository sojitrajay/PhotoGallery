//
//  CategoryImage+CoreDataProperties.swift
//  PhotoGallery
//
//  Created by Jayesh Sojitra on 05/09/17.
//  Copyright © 2017 Jayesh Sojitra. All rights reserved.
//

import Foundation
import CoreData


extension CategoryImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryImage> {
        return NSFetchRequest<CategoryImage>(entityName: "CategoryImage")
    }

    @NSManaged public var url: String?
    @NSManaged public var large_url: String?
    @NSManaged public var id: Int32

}
