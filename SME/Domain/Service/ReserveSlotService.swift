//
//  ReserveSlotService.swift
//  SME
//
//  Created by Aya Essam on 04/01/2021.
//  Copyright © 2021 Aya E Mahmoud. All rights reserved.
//

import Foundation
import Moya

class ReserveSlotService {
    
    var provider = MoyaProvider<ReserveSlotApi>()
    
    func reserveSlot(dictionaryRequest: [String: Any], completion: @escaping (Int?, Error?) -> Void) {
        
        provider.request(.reserveSlot(requestDictionary: dictionaryRequest,
                                      scheduleId: "")) { (response) in
            
            switch response {
               
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                completion(value.statusCode, nil)
            }
        }
    }
}
