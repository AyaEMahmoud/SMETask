//
//  File.swift
//
//  Created by Aya Essam on 12/7/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct File: Codable {

  enum CodingKeys: String, CodingKey {
    case path
    case createdAt = "created_at"
    case id
  }

  var path: String?
  var createdAt: Int?
  var id: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    path = try container.decodeIfPresent(String.self, forKey: .path)
    createdAt = try container.decodeIfPresent(Int.self, forKey: .createdAt)
    id = try container.decodeIfPresent(String.self, forKey: .id)
  }

}
