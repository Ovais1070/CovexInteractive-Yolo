//
//  UserBase.swift
//  User
//
//  Created by CSS on 29/05/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import Foundation

protocol UserBase : JSONSerializable {
    
     var first_name : String? { get }
    var last_name : String? { get }
    var dob : String? { get }
     var mobile : Int? { get }
    var username : String? { get }
    var host : String? { get }

}

