//
//  Reserve.swift
//
//  Created by Aya Essam on 04/01/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Reserve: Codable {

  enum CodingKeys: String, CodingKey {
    case companyId = "company_id"
    case type
    case purpose
  }

  var companyId: String?
  var type: Int?
  var purpose: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    companyId = try container.decodeIfPresent(String.self, forKey: .companyId)
    type = try container.decodeIfPresent(Int.self, forKey: .type)
    purpose = try container.decodeIfPresent(String.self, forKey: .purpose)
  }

}
