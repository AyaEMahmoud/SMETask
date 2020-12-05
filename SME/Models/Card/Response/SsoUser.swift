//
//  SsoUser.swift
//
//  Created by Aya Essam on 12/5/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct SsoUser: Codable {

  enum CodingKeys: String, CodingKey {
    case id
    case gender
    case fullName = "full_name"
    case createdAt = "created_at"
    case nationalIdentity = "national_identity"
    case user
  }

  var id: String?
  var gender: Int?
  var fullName: String?
  var createdAt: Int?
  var nationalIdentity: String?
  var user: User?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(String.self, forKey: .id)
    gender = try container.decodeIfPresent(Int.self, forKey: .gender)
    fullName = try container.decodeIfPresent(String.self, forKey: .fullName)
    createdAt = try container.decodeIfPresent(Int.self, forKey: .createdAt)
    nationalIdentity = try container.decodeIfPresent(String.self, forKey: .nationalIdentity)
    user = try container.decodeIfPresent(User.self, forKey: .user)
  }

}
