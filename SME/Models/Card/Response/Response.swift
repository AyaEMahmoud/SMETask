//
//  Response.swift
//
//  Created by Aya Essam on 12/5/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

class Response: Mappable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
       static let profiles = "data"
       static let status = "status"
       static let success = "success"
    }
    
    // MARK: Properties
    var profiles: [Profiles]?
    var status: Int?
    var success: Bool?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        status <- map[SerializationKeys.status]
        success <- map[SerializationKeys.success]
        profiles <- map[SerializationKeys.profiles]
    }
    
}
