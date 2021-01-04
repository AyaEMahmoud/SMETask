//
//  CompaniesService.swift
//  SME
//
//  Created by Aya Essam on 02/01/2021.
//  Copyright © 2021 Aya E Mahmoud. All rights reserved.
//

import Foundation
import Moya

class CompaniesService {
    
    var provider = MoyaProvider<CompaniesApi>()

    func getUserComapnies(completion: @escaping ([Companies], Error?) -> Void) {
        
        provider.request(.getUserCompanies) { (response) in
            switch response {
               
            case .failure(let error):
                completion([], error)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let companies = try decoder.decode(CompaniesResponse.self, from: value.data)
                    completion(companies.companies ?? [Companies](), nil)
                } catch let error {
                    completion([], error)
                }
            }
        }
    }
}
