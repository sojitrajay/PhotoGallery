//
//  ViewController.swift
//  PhotoGallery
//
//  Created by Jayesh Sojitra on 05/09/17.
//  Copyright © 2017 Jayesh Sojitra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ServerRegistery.sharedInstance.serverCommunicationManager.getWebServiceCallWithRequest(parameters: [:], completion: { (data, response, error) in
            
            if (error != nil) {
                print(error ?? "Error")
            } else {

                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]

                    ServerRegistery.sharedInstance.coredataManager.saveImageData(data: parsedData)
                    
                    let arrayCategoryImages = ServerRegistery.sharedInstance.coredataManager.getAllImages()

                    print(arrayCategoryImages.count)
                    
                } catch let error as NSError {
                    print(error)
                }
                
            }
            
        }, WebService: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

