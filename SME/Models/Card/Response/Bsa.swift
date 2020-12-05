//
//  Bsa.swift
//
//  Created by Aya Essam on 12/5/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Bsa: Codable {

  enum CodingKeys: String, CodingKey {
    case id
    case createdAt = "created_at"
  }

  var id: String?
  var createdAt: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(String.self, forKey: .id)
    createdAt = try container.decodeIfPresent(Int.self, forKey: .createdAt)
  }

}
