//
//  CompanyPresenter.swift
//  SME
//
//  Created by Aya Essam on 02/01/2021.
//  Copyright © 2021 Aya E Mahmoud. All rights reserved.
//

import UIKit
import Moya
import Alamofire

protocol CompanyPresenterView: class {
    func updateCompaniesModel(companies: [Companies])
    func displayErrorToast(isInternetConnectionError: Bool)
}

class CompanyPresenter {
    
    weak var view: CompanyPresenterView?
    
    let networkManager = CompaniesService()
    var page = 1
    var companies: [Companies] = []
    
    init(with view: CompanyPresenterView) {
    self.view = view

    }
    
    func getUserCompanies() {
        networkManager.getUserComapnies { (companies, error) in
        if error == nil {
            self.companies = companies
            self.view?.updateCompaniesModel(companies: self.companies)
            } else {
            if let error = ((error as? MoyaError)?
                                .errorUserInfo["NSUnderlyingError"] as? Alamofire.AFError)?.underlyingError as NSError?,
                error.domain == NSURLErrorDomain,
                error.code == NSURLErrorNotConnectedToInternet
                    || error.code == NSURLErrorTimedOut
                    || error.code == NSURLErrorNetworkConnectionLost {
                
                self.view?.displayErrorToast(isInternetConnectionError: true)
            } else {
                self.view?.displayErrorToast(isInternetConnectionError: false)
            }
            }
        }
        
    }
}
