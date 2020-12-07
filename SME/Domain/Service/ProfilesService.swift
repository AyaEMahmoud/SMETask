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

class ProfilesService: Networkable {
    
    var provider = MoyaProvider<ProfilesApi>()

    func getProfiles(profilesRequest: ProfilesRequest, completion: @escaping ([Profiles], Error?) -> Void) {
        
        provider.request(.getProfiles(profilesRequest: profilesRequest)) { (response) in
            switch response {
               
            case .failure(let error):
                completion([], error)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let profiles = try decoder.decode(Response.self, from: value.data)
                    completion(profiles.profiles ?? [], nil)
                } catch let error {
                    completion([], error)
                }
            }
        }
    }
    
//    var provider: MoyaProvider<ProfilesApi>
//
//   class func getProfiels(profilesRequest:ProfilesRequest, completionHandler: @escaping ([Profiles], Error?)-> Void) {
//
//            let provider = MoyaProvider<ProfilesApi>()
//            provider.request(.getProfiles(profilesRequest: profilesRequest), completion: { result in
//                switch result {
//                case let .success(profilesResponse):
//                    let decoder = JSONDecoder()
//                    do {
//                        print(try profilesResponse.mapJSON() as! [String: Any])
//                        let response = try decoder.decode([Profiles].self, from: profilesResponse.data)
////                        let response = Mapper<Response>().map(JSON: try profilesResponse.mapJSON() as! [String : Any])
//                        print("profiles.isEmpty response?.profiles \(response?.profiles)")
//                        completionHandler(response?.profiles ?? [], nil)
//                    } catch {
//                        completionHandler([], error)
//                    }
//                    case .failure(let error):
//                    completionHandler([], error)
//                }
//
//            })
//    }
}
