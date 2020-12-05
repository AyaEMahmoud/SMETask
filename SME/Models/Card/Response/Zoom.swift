//
//  Zoom.swift
//
//  Created by Aya Essam on 12/5/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Zoom: Codable {

  enum CodingKeys: String, CodingKey {
    case meetingPassword = "meeting_password"
    case pid
    case id
    case email
    case createdAt = "created_at"
  }

  var meetingPassword: String?
  var pid: String?
  var id: String?
  var email: String?
  var createdAt: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    meetingPassword = try container.decodeIfPresent(String.self, forKey: .meetingPassword)
    pid = try container.decodeIfPresent(String.self, forKey: .pid)
    id = try container.decodeIfPresent(String.self, forKey: .id)
    email = try container.decodeIfPresent(String.self, forKey: .email)
    createdAt = try container.decodeIfPresent(Int.self, forKey: .createdAt)
  }

}
