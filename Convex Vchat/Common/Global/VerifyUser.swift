//
//  UserVerification.swift
//  ConvexVchat
//
//  Created by 1234 on 6/17/20.
//  Copyright © 2020 n0. All rights reserved.
//

import Foundation

struct VerifyUser : JSONSerializable {
    
    var data : VerifyUserdata
    var message : String?
    var code : Int?
    var status : Bool?
    

}
