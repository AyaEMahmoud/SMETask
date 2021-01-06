//
//  ProjectsResponse.swift
//
//  Created by Aya Essam on 02/01/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct ProjectsResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case status
    case projects = "data"
    case success
  }

  var status: Int?
  var projects: [Projects]?
  var success: Bool?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    status = try container.decodeIfPresent(Int.self, forKey: .status)
    projects = try container.decodeIfPresent([Projects].self, forKey: .projects)
    success = try container.decodeIfPresent(Bool.self, forKey: .success)
  }

}
