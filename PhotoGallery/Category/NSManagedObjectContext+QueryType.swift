//
//  NSManagedObjectContext+QueryType.swift
//  PhotoGallery
//
//  Created by Jayesh Sojitra on 05/09/17.
//  Copyright © 2017 Jayesh Sojitra. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext{
    
    func getAllDataFor(entity : String) -> Array<AnyObject> {
        
        var array = Array<AnyObject>()
        
        let entityDescription = NSEntityDescription.entity(forEntityName: entity, in: self)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        request.returnsObjectsAsFaults = false
        request.entity = entityDescription
        
        do {
            array = try self.fetch(request)
        } catch {
            array = Array<NSManagedObject>.init()
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        return array as! Array<NSManagedObject>
        
    }
    
    func getDataFor(entity : String, Condition condition: String, Arguments args : CVarArg...) -> Array<AnyObject> {
        
        var array = Array<AnyObject>()
        
        let entityDescription = NSEntityDescription.entity(forEntityName: entity, in: self)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        if args.count > 0 {
            let predicate : NSPredicate = withVaList(args){_ in
                self.predicate(condition: condition, withArgument: getVaList(args))
            }
            request.predicate = predicate
        }
        
        request.returnsObjectsAsFaults = false
        request.entity = entityDescription
        
        do {
            array = try self.fetch(request)
        } catch {
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        return array as! Array<NSManagedObject>
        
    }
    
    func insertInto(entity : String) -> NSManagedObject {
        
        var managedObject : NSManagedObject!
        managedObject = NSEntityDescription.insertNewObject(forEntityName: entity, into: self)
        return managedObject
        
    }
    
    func insertInto(entity : String, AgainstConditions condition : String , Arguments args : CVarArg...) -> NSManagedObject {
        
        var managedObject : NSManagedObject!
        
        if args.count > 0 {
            
            var array = Array<AnyObject>()
            
            let entityDescription = NSEntityDescription.entity(forEntityName: entity, in: self)
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            
            let predicate : NSPredicate = withVaList(args){_ in
                self.predicate(condition: condition, withArgument: getVaList(args))
            }
            request.predicate = predicate
            request.returnsObjectsAsFaults = false
            request.entity = entityDescription
            
            do {
                array = try self.fetch(request)
            } catch {
                print("Fetch failed: \(error.localizedDescription)")
            }
            
            if array.count > 0 {
                managedObject = array.first as! NSManagedObject
            }else{
                managedObject = self.insertInto(entity: entity)
            }
            return managedObject
            
        }
        managedObject = NSEntityDescription.insertNewObject(forEntityName: entity, into: self)
        return managedObject
        
    }
    
    func deleteAllRecordsFor(entity : String, commit : Bool) -> Bool {
        
        var array = Array<AnyObject>()
        array = self.getAllDataFor(entity: entity)
        if array.count > 0 {
            for managedObject:NSManagedObject in array as! Array<NSManagedObject> {
                self.delete(managedObject)
            }
        }
        return self.commit()
        
    }
    
    func deleteRecordsFor(entity : String, Condition condition: String, Arguments args : CVarArg..., commit : Bool) -> Bool {
        
        var array = Array<AnyObject>()
        
        if args.count > 0 {
            let entityDescription = NSEntityDescription.entity(forEntityName: entity, in: self)
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            
            if args.count > 0 {
                let predicate : NSPredicate = withVaList(args){_ in
                    self.predicate(condition: condition, withArgument: getVaList(args))
                }
                request.predicate = predicate
            }
            
            request.returnsObjectsAsFaults = false
            request.entity = entityDescription
            
            do {
                array = try self.fetch(request)
            } catch {
                print("Fetch failed: \(error.localizedDescription)")
            }
        }
        
        if array.count > 0 {
            for managedObject:NSManagedObject in array as! Array<NSManagedObject> {
                self.delete(managedObject)
            }
        }
        if commit == true {
            return self.commit()
        }
        else{
            return false
        }
    }
    
    func predicate(condition : String, withArgument argument : CVaListPointer) -> NSPredicate {
        let predicate = NSPredicate(format: condition, arguments: argument)
        return predicate
    }
    
    func commit() -> Bool {
        do {
            try self.save()
            return true
        } catch {
            print("Save failed: \(error.localizedDescription)")
            return false
        }
        
    }
    
}
