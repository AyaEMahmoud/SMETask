//
//  ProjectsApi.swift
//  SME
//
//  Created by Aya Essam on 02/01/2021.
//  Copyright © 2021 Aya E Mahmoud. All rights reserved.
//

import Foundation
import Moya

enum ProjectsApi {
    case getUserProjects
}

extension ProjectsApi: TargetType {
 
    public var baseURL: URL { return URL(string: APPURL.BaseURL)! }
    
    public var path: String {
        switch self {
        case .getUserProjects:
            return APPURL.Paths.projects
        }
    }
    
    public var method: Moya.Method {
       switch self {
       case .getUserProjects:
        return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .getUserProjects:
            return .requestParameters(parameters: [:],
                                      encoding: URLEncoding.default)
        }
    }
    
    var sampleData: Data { return Data() }  // We just need to return something here to fully implement the protocol
    
    public var headers: [String: String]? {
        return [KeyConstants.Headers.contentType: KeyConstants.Headers.contentTypeValue,
                KeyConstants.Headers.authorization: KeyConstants.TokenWithProjectsAndCompanies]
    }
}
