//
//  CompaniesResponse.swift
//
//  Created by Aya Essam on 02/01/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct CompaniesResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case status
    case companies = "data"
    case success
  }

  var status: Int?
  var companies: [Companies]?
  var success: Bool?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    status = try container.decodeIfPresent(Int.self, forKey: .status)
    companies = try container.decodeIfPresent([Companies].self, forKey: .companies)
    success = try container.decodeIfPresent(Bool.self, forKey: .success)
  }

}
