//
//  ServerComunicationManager.swift
//  PhotoGallery
//
//  Created by Jayesh Sojitra on 05/09/17.
//  Copyright © 2017 Jayesh Sojitra. All rights reserved.
//

import UIKit
import Foundation

class ServerComunicationManager: NSObject {
    
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    func getWebServiceCallWithRequest(parameters : Dictionary<String, Any>, completion: @escaping CompletionHandler, WebService webService:String) -> Void {

        let request = NSMutableURLRequest(url: NSURL(string: "http://www.splashbase.co/api/v1/images/search?query=laptop")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 120.0)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error ?? "Error")
                completion(data, response, error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse ?? "Error")
                completion(data, response, error)
            }
        })
        
        dataTask.resume()

        
    }
    
}
