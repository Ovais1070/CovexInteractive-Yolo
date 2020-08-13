//
//  data.swift
//  ConvexVchat
//
//  Created by 1234 on 6/17/20.
//  Copyright © 2020 n0. All rights reserved.
//

import Foundation

class Profiledata : JSONSerializable {
    
//    {
//        code = 200;
//        data =     {
//            dob = "1993-01-01";
//            "first_name" = "first_name";
//            host = "first_name.last_name43@srv3.mjunoon.tv";
//            "last_name" = "last_name";
//            mobile = 923316519596;
//            password = 123789;
//            username = "first_name.last_name43";
//        };
//        message = "User has been added successfully";
//        status = 1;
//    }
    
   // var id : Int?
    var first_name : String?
    var last_name : String?
    var dob : String?
    var mobile : String?
     var password : String?
    var username : String?
    var exist : Bool?

    var host : String?

    required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
       // id = try? values.decode(Int.self, forKey: .id)
        first_name = try? values.decode(String.self, forKey: .first_name)
        last_name = try? values.decode(String.self, forKey: .last_name)
        dob = try? values.decode(String.self, forKey: .dob)
        username = try? values.decode(String.self, forKey: .username)
        host = try? values.decode(String.self, forKey: .host)
        password = try? values.decode(String.self, forKey: .password)
        exist = try? values.decode(Bool.self, forKey: .exist)

        if let mobileInt = try? values.decode(Int.self, forKey: .mobile) {
            mobile = "\(mobileInt)"
        } else {
            mobile = try? values.decode(String.self, forKey: .mobile)
        }
        
    }
    
    init() {
    }
}

class VerifyUserdata : JSONSerializable {
    
//    {
//        code = 200;
//        data =     {
//            dob = "1993-01-01";
//            "first_name" = "first_name";
//            host = "first_name.last_name43@srv3.mjunoon.tv";
//            "last_name" = "last_name";
//            mobile = 923316519596;
//            password = 123789;
//            username = "first_name.last_name43";
//        };
//        message = "User has been added successfully";
//        status = 1;
//    }
    
   // var id : Int?
    var first_name : String?
    var last_name : String?
    var dob : String?
    var mobile : String?
     var password : String?
    var username : String?
    var exist : Bool?

    var host : String?

    required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
       // id = try? values.decode(Int.self, forKey: .id)
        first_name = try? values.decode(String.self, forKey: .first_name)
        last_name = try? values.decode(String.self, forKey: .last_name)
        dob = try? values.decode(String.self, forKey: .dob)
        username = try? values.decode(String.self, forKey: .username)
        host = try? values.decode(String.self, forKey: .host)
        exist = try? values.decode(Bool.self, forKey: .exist)

        password = try? values.decode(String.self, forKey: .password)

        if let mobileInt = try? values.decode(Int.self, forKey: .mobile) {
            mobile = "\(mobileInt)"
        } else {
            mobile = try? values.decode(String.self, forKey: .mobile)
        }
        
    }
    
    init() {
    }
}
