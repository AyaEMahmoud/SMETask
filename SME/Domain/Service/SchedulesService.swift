//
//  SchedulesService.swift
//  SME
//
//  Created by Aya Essam on 24/12/2020.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import Foundation
import Moya

class SchedulesService {
    
    var provider = MoyaProvider<SchedulesApi>()

    func getSchedules(contributerId: String, completion: @escaping ([Schedules], Error?) -> Void) {
        
        provider.request(.getSchedules(contributerId: contributerId)) { (response) in
            switch response {
        
            case .failure(let error):
                completion([], error)
                
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let schedules = try decoder.decode(SchedulesData.self, from: value.data)
                    completion(schedules.schedules ?? [], nil)
                } catch let error {
                    completion([], error)
                }
            }
        }
    }
}
