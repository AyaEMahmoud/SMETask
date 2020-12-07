//
//  InternetChecker.swift
//  
//
//  Created by
//  Copyright © 2017 SmarTech. All rights reserved.
//

import UIKit
import Reachability
import SystemConfiguration

enum ReachabilityStatus: String {
    case REACHABLEVIAWIFI = "Reachable via WiFi"
    case REACHABLEVIACELLULAR = "Reachable via Cellular"
    case NOTREACHABLE = "Not reachable"
    case UNABLETOSTART = "Unable to start notifier"
}

class InternetChecker: NSObject {
    
    static let shared = InternetChecker()
    let reachability = try! Reachability()

    func checkForInternet(withResult: @escaping ((ReachabilityStatus) -> Void)) {
        reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async { [weak self] in
                if reachability.connection == .wifi {
                    withResult(.REACHABLEVIAWIFI)
                } else {
                    withResult(.REACHABLEVIACELLULAR)
                }
            }
        }
        reachability.whenUnreachable = { _ in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            
            DispatchQueue.main.async { [weak self] in
                withResult(.NOTREACHABLE)
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            withResult(.UNABLETOSTART)
        }
    }
    
    func stopCheckingForInternet() {
        reachability.stopNotifier()
    }
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
}
