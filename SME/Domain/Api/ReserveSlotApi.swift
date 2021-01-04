//
//  ReserveSlotApi.swift
//  SME
//
//  Created by Aya Essam on 04/01/2021.
//  Copyright © 2021 Aya E Mahmoud. All rights reserved.
//

import Foundation
import Moya

enum ReserveSlotApi {
    case reserveSlot(requestDictionary: [String: Any], scheduleId: String)
}

extension ReserveSlotApi: TargetType {
 
    public var baseURL: URL { return URL(string: APPURL.BaseURL)! }
    
    public var path: String {
        switch self {
        case .reserveSlot(_, let scheduleId):
            return APPURL.Paths.reserveSlot + "\(scheduleId)" + "/sessions"
        }
    }
    
    public var method: Moya.Method {
       switch self {
       case .reserveSlot:
        return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .reserveSlot(let requestDictionary, _):
            return .requestParameters(parameters: requestDictionary,
                                      encoding: URLEncoding.default)
        }
    }
    
    var sampleData: Data { return Data() }  // We just need to return something here to fully implement the protocol
    
    public var headers: [String: String]? {
        return [KeyConstants.Headers.contentType: KeyConstants.Headers.contentTypeValue,
                KeyConstants.Headers.authorization: KeyConstants.TokenWithProjectsAndCompanies]
    }
}
