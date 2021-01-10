//
//  Enviroment.swift
//  Monshaat_SMEOwner_IOS
//
//  Created by Mai on 11/20/19.
//  Copyright © 2019 Ibtikar. All rights reserved.
//

import Foundation

public enum Environment {
    // MARK: - Keys

    enum PlistKeys {
        static let rootURL = "BASE_URL"
        static let apiKey = "API_KEY"
        static let firebaseService = "FIREBASE_KEY"
        static let redirectURL = "REDIRECT_URL"
        static let consumerKey = "CONSUMER_KEY"
        static let consumerSecret = "CONSUMER_SECRET"
        static let fetchDuration = "FORCEUPDATE_EXPIRATION_DURATION"
        static let domainURIPrefix = "DOMAIN_URI_PREFIX"
    }

    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    // MARK: - Plist values
    static let rootURL: String = {
        guard let rootURLstring = Environment.infoDictionary[PlistKeys.rootURL] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }
        let baseUrl = "https://\(rootURLstring)"
        guard let url = URL(string: baseUrl ) else {
            fatalError("Root URL is invalid")
        }
        print("url version", url.absoluteString )
        return url.absoluteString
    }()
    static let apiKey: String = {
        guard let apiKey = Environment.infoDictionary[PlistKeys.apiKey] as? String else {
            fatalError("API Key not set in plist for this environment")
        }
        return apiKey
    }()
    static let firebaseService: String = {
         guard let firebaseService = Environment.infoDictionary[PlistKeys.firebaseService] as? String else {
             fatalError("API Key not set in plist for this environment")
         }
        print(firebaseService)
         return firebaseService
     }()
   static let redirectURL: String = {
        guard let redirectURL = Environment.infoDictionary[PlistKeys.redirectURL] as? String else {
            fatalError("redirectURL not set in plist for this environment")
        }
        return redirectURL
    }()
 
    static let consumerKey: String = {
          guard let consumerKey = Environment.infoDictionary[PlistKeys.consumerKey] as? String else {
              fatalError("consumerKey not set in plist for this environment")
          }
          return consumerKey
      }()
    
    static let consumerSecret: String = {
            guard let consumerSecret = Environment.infoDictionary[PlistKeys.consumerSecret] as? String else {
                fatalError("consumerSecret not set in plist for this environment")
            }
            return consumerSecret
        }()
    static let fetchDuration: String = {
            guard let fetchDuration = Environment.infoDictionary[PlistKeys.fetchDuration] as? String else {
                fatalError("consumerSecret not set in plist for this environment")
            }
            return fetchDuration
        }()
    static let domainURIPrefix: String = {
            guard let domainURIPrefix = Environment.infoDictionary[PlistKeys.domainURIPrefix] as? String else {
                fatalError("consumerSecret not set in plist for this environment")
            }
            return domainURIPrefix
        }()
}
