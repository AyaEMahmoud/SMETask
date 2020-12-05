//
//  KeyConstants.swift
//  Monsh2atTask
//
//  Created by Aya Essam on 12/3/20.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import Foundation

struct KeyConstants {
    
    static let DeviceType = "iOS"
    
    struct UserDefaults {
        static let userRunningAppFirstTime = "userRunningAppFirstTime"
    }
    
    struct NewsDefaults {
          static let defaultCountryCode = "US"
          static let PageSize = 15
    }
    
    struct Headers {
        static let Authorization = "Authorization"
        static let ContentType = "Content-Type"
        static let NewsApiKey = ""
        static let apiKey = "X-Api-Key"
        static let apiValue = ""
        static let lang = "Accept-Language"
        static let authorization = "Authorization"
        static let contentType = "Content-type"
        static let contentTypeValue = "application/json"
        static let encoding = "Accept-Encoding"
        static let encodingValue = "application/json"
    }
    
    struct ErrorMessage {
        static let listNotFound = "ERROR_LIST_NOT_FOUND"
        static let validationError = "ERROR_VALIDATION"
    }
}
