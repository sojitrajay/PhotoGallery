//
//  ServerRegistery.swift
//  PhotoGallery
//
//  Created by Jayesh Sojitra on 05/09/17.
//  Copyright © 2017 Jayesh Sojitra. All rights reserved.
//

import UIKit

class ServerRegistery: NSObject {
    
    static let sharedInstance : ServerRegistery = {
        let instance = ServerRegistery()
        return instance
    }()
    
    let coredataManager : CoreDataManager = {
        let instance = CoreDataManager()
        instance.managedObjContext = appDelegate.persistentContainer.viewContext
        return instance
    }()
    
    let serverCommunicationManager : ServerComunicationManager = {
        let instance = ServerComunicationManager()
        return instance
    }()

    
}
