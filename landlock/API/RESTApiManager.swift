//
//  RESTApiManager.swift
//  landlock
//
//  Created by Tewodros Wondimu on 11/30/17.
//  Copyright © 2017 Tewodros Wondimu. All rights reserved.
//

import Foundation
/*
class RESTApiManager: NSObject {
    
    var baseURL: URL?
    var modelType: String?
    var model: Any?
    
    // instantiates a rest api manager with a base URL
    init(url: String, type: String) {
        guard let guardURL = URL(string: url) else { return }
        baseURL = guardURL
        modelType = type
    }
    
    func getModel() {
        
        URLSession.shared.dataTask(with: baseURL!) { (data, response, error) in
            // Check if there is an error
            // Check if the response status is 200 OK
            
            // Get a non-optional data string
            guard let data = data else { return }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                
                guard let results = json["results"] as? [String: Any] else { return }
                
                guard let object = self.modelFactory(json: results, type: self.modelType!) else { return }
                
                self.model = object
            } catch let jsonErr {
                print("Error serializing json: \(jsonErr)")
            }
            }.resume()
        
    }
    
    func modelFactory(json: [String: Any], type: String) -> Any? {
        switch type {
            case "Property":
                return Property(json: json)
            default:
                print("The object type does not exist")
        }
        return ""
    }
    
}*/
