//
//  User.swift
//  User
//
//  Created by CSS on 17/01/18.
//  Copyright © 2018 Appoets. All rights reserved.
//


import Foundation

class User : NSObject, NSCoding, JSONSerializable {
    //public var user_Login_dictionary : NSMutableDictionary!

    static var main = initializeUserData()
    
   var first_name : String?
    var last_name : String?
    var dob : String?
    var mobile : String?
     var password : String?
    var username : String?

    var host : String?

    
    init(firstName : String?, lastName : String?,username : String?, mobile : String? , dob : String?,  host : String?){
        
        self.mobile = mobile
        self.dob = dob
        self.first_name = firstName
        self.last_name = lastName
        self.username = lastName
        self.host = host

    }
    
    convenience
    override init(){
        self.init(firstName: nil, lastName: nil, username: nil, mobile : nil, dob : nil, host : nil)
    }
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let dob = aDecoder.decodeObject(forKey: Keys.list.dob) as? String
        let host = aDecoder.decodeObject(forKey: Keys.list.host) as? String
        let firstName = aDecoder.decodeObject(forKey: Keys.list.firstName) as? String
        let lastName = aDecoder.decodeObject(forKey: Keys.list.lastName) as? String
         let mobile = aDecoder.decodeObject(forKey: Keys.list.mobile) as? String
        let username = aDecoder.decodeObject(forKey: Keys.list.username) as? String

        
        self.init(firstName: firstName, lastName : lastName, username : username, mobile : mobile, dob:dob, host:host)
        
    }
    
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(self.dob, forKey: Keys.list.dob)
        aCoder.encode(self.host, forKey: Keys.list.host)
        aCoder.encode(self.first_name, forKey: Keys.list.firstName)
        aCoder.encode(self.last_name, forKey: Keys.list.lastName)
        aCoder.encode(self.username, forKey: Keys.list.username)
        aCoder.encode(self.mobile, forKey: Keys.list.mobile)

    
}





}



