//
//  Property.swift
//  landlock
//
//  Created by Tewodros Wondimu on 11/30/17.
//  Copyright © 2017 Tewodros Wondimu. All rights reserved.
//

import Foundation

class Property {
    // Define properties of a Property (Land)
    var id: String
    var landSize: Double
    var address: Address?
    var landStatus: String
    var parent: String
    var children: [String]
    var owner: Person
    
    init(id: String, landSize: Double, address: Address?, landStatus: String, parent: String, children: [String], owner: Person) {
        self.id = id
        self.landSize = landSize
        self.address = address
        self.landStatus = landStatus
        self.parent = parent
        self.children = children
        self.owner = owner
    }
}
