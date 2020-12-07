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
}
