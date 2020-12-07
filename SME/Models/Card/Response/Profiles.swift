//
//  Profiles.swift
//
//  Created by Aya Essam on 12/5/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Profiles: Codable {

  enum CodingKeys: String, CodingKey {
    case onlineEnabled = "online_enabled"
    case isAvailable = "is_available"
    case isOnline = "is_online"
    case joinNowEnabled = "join_now_enabled"
    case ssoUser = "sso_user"
    case zoom = "zoom"
    case rating = "rating"
    case availability = "availability"
    case chatStatus = "chat_status"
    case id = "id"
    case office = "office"
    case subject = "subject"
    case createdAt = "created_at"
//    case interests = "interests"
    case bsa = "bsa"
  }

  var onlineEnabled: Bool?
  var isAvailable: Bool?
  var isOnline: Bool?
  var joinNowEnabled: Bool?
  var ssoUser: SsoUser?
  var zoom: Zoom?
  var rating: Double?
  var availability: Int?
  var chatStatus: Bool?
  var id: String?
  var office: Office?
  var subject: Subject?
  var createdAt: Int?
//  var interests: [String]?
  var bsa: Bsa?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    onlineEnabled = try container.decodeIfPresent(Bool.self, forKey: .onlineEnabled)
    isAvailable = try container.decodeIfPresent(Bool.self, forKey: .isAvailable)
    isOnline = try container.decodeIfPresent(Bool.self, forKey: .isOnline)
    joinNowEnabled = try container.decodeIfPresent(Bool.self, forKey: .joinNowEnabled)
    ssoUser = try container.decodeIfPresent(SsoUser.self, forKey: .ssoUser)
    zoom = try container.decodeIfPresent(Zoom.self, forKey: .zoom)
    rating = try container.decodeIfPresent(Double.self, forKey: .rating)
    availability = try container.decodeIfPresent(Int.self, forKey: .availability)
    chatStatus = try container.decodeIfPresent(Bool.self, forKey: .chatStatus)
    id = try container.decodeIfPresent(String.self, forKey: .id)
    office = try container.decodeIfPresent(Office.self, forKey: .office)
    subject = try container.decodeIfPresent(Subject.self, forKey: .subject)
    createdAt = try container.decodeIfPresent(Int.self, forKey: .createdAt)
    //interests = try container.decodeIfPresent([String].self, forKey: .interests)
    bsa = try container.decodeIfPresent(Bsa.self, forKey: .bsa)
  }

}
