//
//  Networkable.swift
//  SME
//
//  Created by Aya Essam on 12/5/20.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<ProfilesApi> { get }
    
    func getProfiles(profilesRequest: ProfilesRequest, completion: @escaping ([Profiles], Error?) -> Void)
}
