//
//  SchedulesApi.swift
//  SME
//
//  Created by Aya Essam on 24/12/2020.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import Foundation
import Moya

enum SchedulesApi {
    case getSchedules(contributerId: String)
}

extension SchedulesApi: TargetType {
 
    public var baseURL: URL { return URL(string: APPURL.BaseURL)! }
    
    public var path: String {
        switch self {
        case .getSchedules(let contributerId):
            return APPURL.Paths.AvaSlots + "\(contributerId)"
        }
    }
    
    public var method: Moya.Method {
       switch self {
       case .getSchedules:
        return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .getSchedules:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        }
    }
    
    var sampleData: Data { return Data() }  // We just need to return something here to fully implement the protocol
    
    public var headers: [String: String]? {
        return [KeyConstants.Headers.contentType: KeyConstants.Headers.contentTypeValue]
    }
}
