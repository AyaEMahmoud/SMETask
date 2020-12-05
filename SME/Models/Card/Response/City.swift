//
//  City.swift
//
//  Created by Aya Essam on 12/5/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct City: Codable {

  enum CodingKeys: String, CodingKey {
    case id = "id"
    case createdAt = "created_at"
    case name = "name"
  }

  var id: String?
  var createdAt: Int?
  var name: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(String.self, forKey: .id)
    createdAt = try container.decodeIfPresent(Int.self, forKey: .createdAt)
    name = try container.decodeIfPresent(String.self, forKey: .name)
  }

}
