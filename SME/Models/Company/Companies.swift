//
//  Companies.swift
//
//  Created by Aya Essam on 02/01/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Companies: Codable {

  enum CodingKeys: String, CodingKey {
    case creationDate = "creation_date"
    case cr
    case id
    case name
  }

  var creationDate: String?
  var cr: String?
  var id: String?
  var name: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    creationDate = try container.decodeIfPresent(String.self, forKey: .creationDate)
    cr = try container.decodeIfPresent(String.self, forKey: .cr)
    id = try container.decodeIfPresent(String.self, forKey: .id)
    name = try container.decodeIfPresent(String.self, forKey: .name)
  }

}
