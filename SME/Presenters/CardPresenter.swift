//
//  CardPresenter.swift
//  SME
//
//  Created by Aya Essam on 12/7/20.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import Foundation

protocol CardPresenterView: class {
    func updateModel(profiles: [Profiles])
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
           let profilesRequest = ProfilesRequest(byParameter: "نافذة الاستفسارات العامة", page: page)
           networkManager.getProfiles(profilesRequest: profilesRequest) { (profiles, error) in
              if error == nil {
                   if self.page == 1 {
                      self.profiles = profiles

                   } else {
                      self.profiles.append(contentsOf: profiles)
                   }
                
                self.view?.updateModel(profiles: self.profiles)
                
               } else {
                   
               }
           }
       }
}
