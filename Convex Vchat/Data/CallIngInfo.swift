//
//  CallInfo.swift
//  ConvexVchat
//
//  Created by Ovais Naveed on 9/17/20.
//  Copyright © 2020 n0. All rights reserved.
//

import Foundation

struct CallingInfo{
    var name: String
    var callType: String
    var isReceivingCall: Bool = false
    var sdp: String
    var data: CallingInfoData
    
    init(name: String, callType: String, isReceivingCall: Bool, sdp: String, data: CallingInfoData) {
        self.name = name
        self.callType = callType
        self.isReceivingCall = isReceivingCall
        self.sdp = sdp
        self.data = data
    }
}

struct CallingInfoData{
    var firstName: String
    var lastName: String
    var username: String
    var profilePicture: String
    var email: String
    var mobile: String
    var address: String
    var deviceId: String
    var dob: String
    var host: String
    var mood: String
    var password: String
    var work: String
    
    init(firstName: String, lastName: String, username: String, profilePicture: String, email: String, mobile: String, address: String, deviceId: String, dob: String, work: String, host: String, mood: String, password: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.profilePicture = profilePicture
        self.email = email
        self.mobile = mobile
        self.address = address
        self.deviceId = deviceId
        self.dob = dob
        self.work = work
        self.host = host
        self.mood = mood
        self.password = password
    }
}
