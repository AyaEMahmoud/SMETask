//
//  ReserveSlotPresenter.swift
//  SME
//
//  Created by Aya Essam on 04/01/2021.
//  Copyright © 2021 Aya E Mahmoud. All rights reserved.
//

import Foundation
import Moya
import Alamofire

protocol ReserveSlotView: class {
    func displayToast(isInternetConnectionError: Bool)
    func displaySuccessToast()
}

class ReserveSlotPresenter {
    
    weak var view: ReserveSlotView?
    let networkManager = ReserveSlotService()
    
    init(with view: ReserveSlotView) {
        self.view = view
    }
    
    func reserveSlot(dictionaryRequest: [String: Any]) {
        networkManager.reserveSlot(dictionaryRequest: dictionaryRequest) { (success, error) in
            if error == nil {
                print("scueess \(success)")
                self.view?.displaySuccessToast()
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
