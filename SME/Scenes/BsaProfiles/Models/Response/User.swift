//
//  User.swift
//
//  Created by Aya Essam on 12/5/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct User: Codable {

  enum CodingKeys: String, CodingKey {
    case email = "email"
    case createdAt = "created_at"
    case id = "id"
  }

  var email: String?
  var createdAt: Int?
  var id: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    email = try container.decodeIfPresent(String.self, forKey: .email)
    createdAt = try container.decodeIfPresent(Int.self, forKey: .createdAt)
    id = try container.decodeIfPresent(String.self, forKey: .id)
  }

}
