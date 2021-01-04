//
//  ProjectsSerivce.swift
//  SME
//
//  Created by Aya Essam on 02/01/2021.
//  Copyright © 2021 Aya E Mahmoud. All rights reserved.
//

import Foundation
import Moya

class ProjectsServices {
    
    var provider = MoyaProvider<ProjectsApi>()

    func getUserProjects(completion: @escaping ([Projects], Error?) -> Void) {
        
        provider.request(.getUserProjects) { (response) in
            switch response {
               
            case .failure(let error):
                completion([], error)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let projects = try decoder.decode(ProjectsResponse.self, from: value.data)
                    completion(projects.projects ?? [Projects](), nil)
                } catch let error {
                    completion([], error)
                }
            }
        }
    }
}
