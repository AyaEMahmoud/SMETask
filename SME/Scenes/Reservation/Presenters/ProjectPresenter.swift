//
//  ProjectPresenter.swift
//  SME
//
//  Created by Aya Essam on 02/01/2021.
//  Copyright © 2021 Aya E Mahmoud. All rights reserved.
//

import UIKit
import Moya
import Alamofire

protocol ProjectPresenterView: class {
    func updateProjectsModel(projects: [Projects])
    func displayToast(isInternetConnectionError: Bool)
}

class ProjectPresenter {
    
    weak var view: ProjectPresenterView?
    
    let networkManager = ProjectsServices()
    var page = 1
    var projects: [Projects] = []
    
    init(with view: ProjectPresenterView) {
    self.view = view

    }
    
    func getUserProjects() {
        networkManager.getUserProjects { (projects, error) in
        if error == nil {
            self.projects = projects
            self.view?.updateProjectsModel(projects: self.projects)
            } else {
            if let error = ((error as? MoyaError)?
                                .errorUserInfo["NSUnderlyingError"] as? Alamofire.AFError)?.underlyingError as NSError?,
                error.domain == NSURLErrorDomain,
                error.code == NSURLErrorNotConnectedToInternet
                    || error.code == NSURLErrorTimedOut
                    || error.code == NSURLErrorNetworkConnectionLost {
                
                self.view?.displayToast(isInternetConnectionError: true)
            } else {
                self.view?.displayToast(isInternetConnectionError: false)
            }
            }
        }
        
    }
}
