//
//  SchedulesData.swift
//
//  Created by Aya Essam on 24/12/2020
//  Copyright (c) . All rights reserved.
//

import Foundation

struct SchedulesData: Codable {

  enum CodingKeys: String, CodingKey {
    case day
    case schedules
    case index
  }

  var day: Int?
  var schedules: [Schedules]?
  var index: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    day = try container.decodeIfPresent(Int.self, forKey: .day)
    schedules = try container.decodeIfPresent([Schedules].self, forKey: .schedules)
    index = try container.decodeIfPresent(Int.self, forKey: .index)
  }

}
