//
//  URLConstants.swift
//  Monsh2atTask
//
//  Created by Aya Essam on 12/3/20.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import Foundation

struct APPURL {
    
    private struct Domains {
        static let Demo = "https://demo-smea.ibtikar.sa"
        static let Stage = "https://smea-pc.ibtikar.sa"
    }
    
    private struct Routes {
        static let Api = "/api" // for example api
    }
    
    private  struct Versions {
        static let Version1 = "/v1" // for example V1
        static let Version2 = "/v2" // for example V2
    }
    
    private static let Domain = Domains.Stage
    private static let Version = ""
    private static let Route = Routes.Api
 
    public static var BaseURL: String {
        return  APPURL.Domain + APPURL.Route + APPURL.Version
    }
    
    struct Paths {
        static let Profiles =  "/profile/bsa"
    }
    
}
