//
//  Item.swift
//  Todoey
//
//  Created by Clayton, David on 2/20/18.
//  Copyright © 2018 Clayton, David. All rights reserved.
//

import Foundation

class Item: Codable {
    
    // conforms to both Encodable and Decodable protocals with Codable
    
    var title : String = ""
    var done : Bool = false

}
