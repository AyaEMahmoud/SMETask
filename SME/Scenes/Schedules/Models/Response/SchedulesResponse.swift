//
//  SchedulesResponse.swift
//
//  Created by Aya Essam on 24/12/2020
//  Copyright (c) . All rights reserved.
//

import Foundation

struct SchedulesResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case schedulesData = "data"
    case status = "status"
    case success = "success"
  }

  var schedulesData: [SchedulesData]?
  var status: Int?
  var success: Bool?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    schedulesData = try container.decodeIfPresent([SchedulesData].self, forKey: .schedulesData)
    status = try container.decodeIfPresent(Int.self, forKey: .status)
    success = try container.decodeIfPresent(Bool.self, forKey: .success)
  }

}
