//
//  NSManagedObject+EvaluateValue.swift
//  PhotoGallery
//
//  Created by Jayesh Sojitra on 05/09/17.
//  Copyright © 2017 Jayesh Sojitra. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    
    func evaluate(value : AnyObject?,forAttributeType attributeType:NSAttributeType) -> AnyObject {
        
        if value == nil || value is NSNull {
            if attributeType == NSAttributeType.stringAttributeType {
                return "" as AnyObject
            } else if (attributeType == NSAttributeType.integer16AttributeType) {
                return NSNumber.init(value: 0)
            } else if (attributeType == NSAttributeType.integer32AttributeType) {
                return NSNumber.init(value: 0)
            } else if (attributeType == NSAttributeType.integer64AttributeType) {
                return NSNumber.init(value: 0)
            } else if (attributeType == NSAttributeType.floatAttributeType) {
                return NSNumber.init(value: 0.0)
            } else if (attributeType == NSAttributeType.doubleAttributeType) {
                return NSNumber.init(value: 0.0)
            } else if (attributeType == NSAttributeType.booleanAttributeType) {
                return NSNumber.init(value: false)
            }
        } else {
            if (attributeType == NSAttributeType.stringAttributeType && value is NSNumber) {
                return value!.stringValue as AnyObject? ?? "" as AnyObject
            } else if (attributeType == NSAttributeType.integer16AttributeType || attributeType == NSAttributeType.integer32AttributeType || attributeType == NSAttributeType.integer64AttributeType) {
                if value is String {
                    return NSNumber(value: NSString(string: (value as? String ?? "")).integerValue)
                } else {
                    return NSNumber(value: NSString(string: (value!.stringValue ?? "")).integerValue)
                }
            } else if (attributeType == NSAttributeType.floatAttributeType) {
                if value is String {
                    return NSNumber(value: NSString(string: (value as? String ?? "")).floatValue)
                } else {
                    return NSNumber(value: NSString(string: (value!.stringValue ?? "")).floatValue)
                }
            } else if (attributeType == NSAttributeType.doubleAttributeType) {
                if value is String {
                    return NSNumber(value: NSString(string: (value as? String ?? "")).doubleValue)
                } else {
                    return NSNumber(value: NSString(string: (value!.stringValue ?? "")).doubleValue)
                }
            } else if (attributeType == NSAttributeType.booleanAttributeType) {
                if value is String {
                    return NSNumber(value: NSString(string: (value as? String ?? "")).boolValue)
                } else {
                    return NSNumber(value: NSString(string: (value!.stringValue ?? "")).boolValue)
                }
            }
        }
        return value ?? "" as AnyObject
        
    }
    
}
