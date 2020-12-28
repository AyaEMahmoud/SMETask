//
//  ProfilesApi.swift
//  Monsh2atTask
//
//  Created by Aya Essam on 12/3/20.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import Foundation
import Moya

struct ProfilesParamters {
    static let byParameter = "by"
    static let page = "page"
}

enum ProfilesApi {
    case getProfiles(profilesRequest: ProfilesRequest)
}

extension ProfilesApi: TargetType {
 
    public var baseURL: URL { return URL(string: APPURL.BaseURL)! }
    
    public var path: String {
        switch self {
        case .getProfiles(_):
            return APPURL.Paths.Profiles
        }
    }
    
    public var method: Moya.Method {
       switch self {
       case .getProfiles(_):
        return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .getProfiles(let profilesRequest):
            return .requestParameters(parameters:
                [ProfilesParamters.byParameter: profilesRequest.byParameter,
                 ProfilesParamters.page: profilesRequest.page],
                                      encoding: URLEncoding.default)
        }
    }
    
    var sampleData: Data { return Data() }  // We just need to return something here to fully implement the protocol
    
    public var headers: [String: String]? {
        return [KeyConstants.Headers.contentType: KeyConstants.Headers.contentTypeValue]
    }
}
