//
//  CardPresenter.swift
//  SME
//
//  Created by Aya Essam on 12/7/20.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import UIKit
import Moya
import Alamofire

protocol CardPresenterView: class {
    func updateModel(profiles: [Profiles])
    func updateCollectionBackground()
    func displayToast(isInternetConnectionError: Bool)
    func endLoadMore()
}

class CardPresenter {
    
    weak var view: CardPresenterView?
    
    let networkManager = ProfilesService()
    var page = 1
    var profiles: [Profiles] = []
    
    init(with view: CardPresenterView) {
    self.view = view

    }
    
    func getProfiles() {
        if !InternetChecker.isConnectedToNetwork() && page == 1 {
            self.view?.updateCollectionBackground()
        } else {
            let profilesRequest = ProfilesRequest(byParameter: "نافذة الاستفسارات العامة", page: page)
            networkManager.getProfiles(profilesRequest: profilesRequest) { (profiles, error) in
            if error == nil {
                if self.page == 1 {
                    self.profiles = profiles

                } else {
                    self.profiles.append(contentsOf: profiles)
                }
                
                self.view?.updateModel(profiles: self.profiles)
                if profiles.isEmpty {
                    self.view?.endLoadMore()
                }
                
                } else {
                if let error = ((error as? MoyaError)?.errorUserInfo["NSUnderlyingError"] as? Alamofire.AFError)?.underlyingError as NSError?,
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
}
