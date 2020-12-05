//
//  Center.swift
//
//  Created by Aya Essam on 12/5/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Center: Codable {

  enum CodingKeys: String, CodingKey {
    case id
    case latitude
    case city
    case longitude
    case createdAt = "created_at"
    case name
    case address
  }

  var id: String?
  var latitude: Float?
  var city: City?
  var longitude: Float?
  var createdAt: Int?
  var name: String?
  var address: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(String.self, forKey: .id)
    latitude = try container.decodeIfPresent(Float.self, forKey: .latitude)
    city = try container.decodeIfPresent(City.self, forKey: .city)
    longitude = try container.decodeIfPresent(Float.self, forKey: .longitude)
    createdAt = try container.decodeIfPresent(Int.self, forKey: .createdAt)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    address = try container.decodeIfPresent(String.self, forKey: .address)
  }

}
