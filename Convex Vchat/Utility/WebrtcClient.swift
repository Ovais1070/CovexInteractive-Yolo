//
//  WebRTCClient.swift
//  ConvexVchat
//
//  Created by Ovais Naveed on 9/17/20.
//  Copyright © 2020 n0. All rights reserved.
//

import Foundation

class WebrtcClient: NSObject {
    
    
    
    private static var sharedInstance: WebrtcClient = {
        let instance = WebrtcClient()
        // Configuration
        // ...
        
        var callInfo = [CallingInfo]()
        
        return instance
    }()
    
    
    
    
    
    // MARK: - Accessors
    
    class func instance() -> WebrtcClient {
        return sharedInstance
    }
    
}

