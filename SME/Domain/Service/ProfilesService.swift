//
//  ProfilesService.swift
//  Monsh2atTask
//
//  Created by Aya Essam on 12/3/20.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

class ProfilesService {
    
   class func getProfiels(profilesRequest:ProfilesRequest, completionHandler: @escaping ([Profiles] , Error?)-> Void) {

            let provider = MoyaProvider<ProfilesApi>()
            provider.request(.getProfiles(profilesRequest: profilesRequest), completion: { result in
                switch result {
                case let .success(profilesResponse):
                    do {
                        print(try profilesResponse.mapJSON() as! [String: Any])
                        let response = Mapper<Response>().map(JSON: try profilesResponse.mapJSON() as! [String : Any])
                        print("profiles.isEmpty response?.profiles \(response?.profiles)")
                        completionHandler(response?.profiles ?? [], nil)
                    } catch {
                        completionHandler([], error)
                    }
                    case .failure(let error):
                    completionHandler([], error)
                }
                
            })
    }
}
