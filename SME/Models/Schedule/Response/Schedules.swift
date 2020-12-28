//
//  Schedules.swift
//
//  Created by Aya Essam on 24/12/2020
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Schedules: Codable {

  enum CodingKeys: String, CodingKey {
    case startTime = "start_time"
    case communicationWay = "communication_way"
    case id
  }

  var startTime: Int?
  var communicationWay: Int?
  var id: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    startTime = try container.decodeIfPresent(Int.self, forKey: .startTime)
    communicationWay = try container.decodeIfPresent(Int.self, forKey: .communicationWay)
    id = try container.decodeIfPresent(String.self, forKey: .id)
  }

}
