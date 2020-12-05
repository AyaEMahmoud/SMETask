//
//  Subject.swift
//
//  Created by Aya Essam on 12/5/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Subject: Codable {

  enum CodingKeys: String, CodingKey {
    case title = "title"
    case type = "type"
    case id = "id"
  }

  var title: String?
  var type: Int?
  var id: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    title = try container.decodeIfPresent(String.self, forKey: .title)
    type = try container.decodeIfPresent(Int.self, forKey: .type)
    id = try container.decodeIfPresent(String.self, forKey: .id)
  }

}
