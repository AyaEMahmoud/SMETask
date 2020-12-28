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
    
    static let TokenWithProjects = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvc21lYS1wYy5pYnRpa2FyLnNhXC9hcGlcL2F1dGhlbnRpY2F0aW9uXC9zbWVcL2xvZ2luIiwiaWF0IjoxNjA4NTQyMTMwLCJleHAiOjE3NjYzNDIxMzAsIm5iZiI6MTYwODU0MjEzMCwianRpIjoiaTE3OEZ1VjlVNDRVQ0RKVSIsInN1YiI6IjY3ODhmOTQ3LWZmZWItNDQ5My1iMmMyLTMwZWJlODM0MmNmMyIsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.BYHi-gBeJjPISEoaX0Iy0VNpyaomquEGoNTcGZiYUa0"
    static let TokenWithProjectsAndCompanies = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvc21lYS1wYy5pYnRpa2FyLnNhXC9hcGlcL2F1dGhlbnRpY2F0aW9uXC9zbWVcL2xvZ2luIiwiaWF0IjoxNjA4NTQyMDIzLCJleHAiOjE3NjYzNDIwMjMsIm5iZiI6MTYwODU0MjAyMywianRpIjoiaktIZFk2U1hyVmpFSE5uYyIsInN1YiI6IjgwNzUzZmE1LTk1YTEtNDA3OC1hZDA1LTJkNjdjZmFjY2U5MyIsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.JT9MerNAG-Sw2qwZf6GtTCRCH6nCU1LMWrmgaUHe45k"
    static let Token = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvc21lYS1wYy5pYnRpa2FyLnNhXC9hcGlcL2F1dGhlbnRpY2F0aW9uXC9zbWVcL2xvZ2luIiwiaWF0IjoxNjA4NTQyMzE1LCJleHAiOjE3NjYzNDIzMTUsIm5iZiI6MTYwODU0MjMxNSwianRpIjoiNEFaQkxHRnBaZlBYUWg2UiIsInN1YiI6IjVjNWRiZGFlLTE1MmYtNGJkMC1hYmZkLWQ3MTgxOTdlNzM2ZCIsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.x3VrNpWCDol-D84kkm89NctAlky39njyu6F6aSfEL6w"
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
