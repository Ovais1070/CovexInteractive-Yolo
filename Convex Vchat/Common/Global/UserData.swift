//
//  UserData.swift
//  User
//
//  Created by CSS on 07/05/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import Foundation

class UserData : UserBase {
    var mobile: Int?
    
    
   var first_name : String?
    var last_name : String?
    var dob : String?
    var password : String?
    var username : String?

    var host : String?

}

class ForgotResponse : JSONSerializable {
    
    var user : UserDataResponse?
}

class UserDataResponse : JSONSerializable {
    
    var id : Int?
    var email : String?
    var device_type : DeviceType?
    var device_token : String?
     var password : String?
    var old_password : String?
    var password_confirmation : String?
    var social_unique_id : String?
    var device_id : String?
    var otp : Int?
    
}


