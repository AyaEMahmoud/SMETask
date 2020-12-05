//
//  Response.swift
//
//  Created by Aya Essam on 12/5/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Response: Codable {

  enum CodingKeys: String, CodingKey {
    case profiles = "data"
    case status = "status"
    case success = "success"
  }

  var profiles: [Profiles]?
  var status: Int?
  var success: Bool?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    profiles = try container.decodeIfPresent([Profiles].self, forKey: .profiles)
    status = try container.decodeIfPresent(Int.self, forKey: .status)
    success = try container.decodeIfPresent(Bool.self, forKey: .success)
  }

}

//import Foundation
//import ObjectMapper
//
//class Response: Mappable {
//
//    // MARK: Declaration for string constants to be used to decode and also serialize.
//    private struct SerializationKeys {
//       static let profiles = "data"
//       static let status = "status"
//       static let success = "success"
//    }
//
//    // MARK: Properties
//    var profiles: [Profiles]?
//    var status: Int?
//    var success: Bool?
//
//    required init?(map: Map) { }
//
//    func mapping(map: Map) {
//        status <- map[SerializationKeys.status]
//        success <- map[SerializationKeys.success]
//        profiles <- map[SerializationKeys.profiles]
//    }
//
//}
