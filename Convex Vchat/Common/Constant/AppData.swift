//
//  AppData.swift
//  User
//
//  Created by CSS on 10/01/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import UIKit

let AppName = "Convex Vchat"
var deviceTokenString = Constants.string.noDevice
 


 

let appClientId = 2
let passwordLengthMax = 10
 let baseUrl = "https://srv3.mjunoon.tv:10088/webrtc/api/"  

var supportNumber = "1111"
var supportEmail = "support@ryghthotshot.com"
var offlineNumber = "57777"
let helpSubject = "\(AppName) Help"

let requestInterval : TimeInterval = 60
let requestCheckInterval : TimeInterval = 5
let driverBundleID = "com.ryghtpickup.provider"

var isReferalEnable = 0
// AppStore URL

enum AppStoreUrl : String {
    
    case user = "https://apps.apple.com/us/app/ryght-pickup-user/id1506097354?ls=1"
    case driver = "https://apps.apple.com/us/app/ryght-pickup-driver/id1507022367?ls=1"
    case playStore = "https://play.google.com/store/apps/details?id=com.ryghthotshot.user"
    
}
