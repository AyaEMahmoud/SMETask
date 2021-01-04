//
//  Projects.swift
//
//  Created by Aya Essam on 02/01/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Projects: Codable {

  enum CodingKeys: String, CodingKey {
    case createdAt = "created_at"
    case stage
    case id
    case name
    case purpose
  }

  var createdAt: Int?
  var stage: Int?
  var id: String?
  var name: String?
  var purpose: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    createdAt = try container.decodeIfPresent(Int.self, forKey: .createdAt)
    stage = try container.decodeIfPresent(Int.self, forKey: .stage)
    id = try container.decodeIfPresent(String.self, forKey: .id)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    purpose = try container.decodeIfPresent(String.self, forKey: .purpose)
  }

}
