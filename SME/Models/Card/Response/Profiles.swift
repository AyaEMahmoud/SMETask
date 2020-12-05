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
    case interests = "interests"
    case bsa = "bsa"
  }

  var onlineEnabled: Bool?
  var isAvailable: Bool?
  var isOnline: Bool?
  var joinNowEnabled: Bool?
  var ssoUser: SsoUser?
  var zoom: Zoom?
  var rating: Int?
  var availability: Int?
  var chatStatus: Bool?
  var id: String?
  var office: Office?
  var subject: Subject?
  var createdAt: Int?
  var interests: [String]?
  var bsa: Bsa?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    onlineEnabled = try container.decodeIfPresent(Bool.self, forKey: .onlineEnabled)
    isAvailable = try container.decodeIfPresent(Bool.self, forKey: .isAvailable)
    isOnline = try container.decodeIfPresent(Bool.self, forKey: .isOnline)
    joinNowEnabled = try container.decodeIfPresent(Bool.self, forKey: .joinNowEnabled)
    ssoUser = try container.decodeIfPresent(SsoUser.self, forKey: .ssoUser)
    zoom = try container.decodeIfPresent(Zoom.self, forKey: .zoom)
    rating = try container.decodeIfPresent(Int.self, forKey: .rating)
    availability = try container.decodeIfPresent(Int.self, forKey: .availability)
    chatStatus = try container.decodeIfPresent(Bool.self, forKey: .chatStatus)
    id = try container.decodeIfPresent(String.self, forKey: .id)
    office = try container.decodeIfPresent(Office.self, forKey: .office)
    subject = try container.decodeIfPresent(Subject.self, forKey: .subject)
    createdAt = try container.decodeIfPresent(Int.self, forKey: .createdAt)
    interests = try container.decodeIfPresent([String].self, forKey: .interests)
    bsa = try container.decodeIfPresent(Bsa.self, forKey: .bsa)
  }

}

//import ObjectMapper
//
//class Profiles: Mappable {
//    
//    // MARK: Declaration for string constants to be used to decode and also serialize.
//    private struct SerializationKeys {
//       static let profiles = "data"
//       static let onlineEnabled = "online_enabled"
//       static let isAvailable = "is_available"
//       static let isOnline = "is_online"
//       static let joinNowEnabled = "join_now_enabled"
//       static let ssoUser = "sso_user"
//       static let zoom = "zoom"
//       static let rating = "rating"
//       static let availability = "availability"
//       static let chatStatus = "chat_status"
//       static let id = "id"
//       static let office = "office"
//       static let subject = "subject"
//       static let createdAt = "created_at"
//       static let interests = "interests"
//       static let bsa = "bsa"
//    }
//    
//    // MARK: Properties
//     var onlineEnabled: Bool?
//      var isAvailable: Bool?
//      var isOnline: Bool?
//      var joinNowEnabled: Bool?
//      var ssoUser: SsoUser?
//      var zoom: Zoom?
//      var rating: Int?
//      var availability: Int?
//      var chatStatus: Bool?
//      var id: String?
//      var office: Office?
//      var subject: Subject?
//      var createdAt: Int?
//      var interests: Any?
//      var bsa: Bsa?
//    
//    required init?(map: Map) { }
//    
//    func mapping(map: Map) {
//        onlineEnabled <- map[SerializationKeys.onlineEnabled]
//        isOnline <- map[SerializationKeys.isOnline]
//        isAvailable <- map[SerializationKeys.isAvailable]
//        joinNowEnabled <- map[SerializationKeys.joinNowEnabled]
//        ssoUser <- map[SerializationKeys.ssoUser]
//        zoom <- map[SerializationKeys.zoom]
//        rating <- map[SerializationKeys.rating]
//        availability <- map[SerializationKeys.availability]
//        chatStatus <- map[SerializationKeys.chatStatus]
//        id <- map[SerializationKeys.id]
//        office <- map[SerializationKeys.office]
//        subject <- map[SerializationKeys.subject]
//        createdAt <- map[SerializationKeys.createdAt]
//        bsa <- map[SerializationKeys.bsa]
//        interests <- map[SerializationKeys.interests]
//    }
//    
//}
