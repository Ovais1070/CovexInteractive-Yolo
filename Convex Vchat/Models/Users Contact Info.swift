//
//  Users Contact Info.swift
//  ConvexVchat
//
//  Created by Ovais Naveed on 8/12/20.
//  Copyright © 2020 n0. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserContactInfo : NSObject, NSCoding {
    
    var belongs_to : Int = 0
    var blocked : Int = 0
    var created_at : String = ""
    var deviceId : String = ""
    var exists : Int = 0
    var host : String = ""
    var isOnline : Int = 0
    var is_blocked : Int = 0
    var mood : String = ""
    var name : String = ""
    var number : String = ""
    var profile_pic : String = ""
    var username : String = ""
    
    
    override init() {
        
    }
    
    
    init(data: JSON) {
        self.belongs_to = data["belongs_to"].intValue
        self.blocked = data["blocked"].intValue
        self.created_at = data["created_at"].stringValue
        self.deviceId = data["deviceId"].stringValue
        self.exists = data["exists"].intValue
        self.host = data["host"].stringValue
        self.isOnline = data["isOnline"].intValue
        self.is_blocked = data["is_blocked"].intValue
        self.mood = data["mood"].stringValue
        self.name = data["name"].stringValue
        self.number = data["number"].stringValue
        self.profile_pic = data["profile_pic"].stringValue
        self.username = data["username"].stringValue
    }
    
    
    
    
     required public init(coder aDecoder: NSCoder) {

        self.belongs_to = aDecoder.decodeObject(forKey: "belongs_to") as? Int ?? 0
        self.blocked = aDecoder.decodeObject(forKey: "blocked") as? Int ?? 0
        self.created_at = aDecoder.decodeObject(forKey: "created_at") as? String ?? ""
        self.deviceId = aDecoder.decodeObject(forKey: "deviceId") as? String ?? ""
        self.exists = aDecoder.decodeObject(forKey: "exists") as? Int ?? 0
        self.host = aDecoder.decodeObject(forKey: "host") as? String ?? ""
        self.isOnline = aDecoder.decodeObject(forKey: "isOnline") as? Int ?? 0
        self.is_blocked = aDecoder.decodeObject(forKey: "is_blocked") as? Int ?? 0
        self.mood = aDecoder.decodeObject(forKey: "mood") as? String ?? ""
        self.name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        self.number = aDecoder.decodeObject(forKey: "number") as? String ?? ""
        self.profile_pic = aDecoder.decodeObject(forKey: "profile_pic") as? String ?? ""
        self.username = aDecoder.decodeObject(forKey: "username") as? String ?? ""
        
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(self.belongs_to, forKey: "id")
        aCoder.encode(self.blocked, forKey: "blocked")
        aCoder.encode(self.created_at, forKey: "created_at")
        aCoder.encode(self.deviceId, forKey: "deviceId")
        aCoder.encode(self.exists, forKey: "exists")
        aCoder.encode(self.host, forKey: "host")
        aCoder.encode(self.isOnline, forKey: "isOnline")
        aCoder.encode(self.is_blocked, forKey: "is_blocked")
        aCoder.encode(self.mood, forKey: "mood")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.number, forKey: "number")
        aCoder.encode(self.profile_pic, forKey: "profile_pic")
        aCoder.encode(self.username, forKey: "username")
    }

    
    
    init(belongs_to: Int, blocked: Int, created_at: String, deviceId: String, exists: Int, host: String, isOnline: Int, is_blocked: Int, mood: String, name: String, number: String, profile_pic: String, username: String ) {
        
        self.belongs_to = belongs_to
        self.blocked = blocked
        self.created_at = created_at
        self.deviceId = deviceId
        self.exists = exists
        self.host = host
        self.isOnline = isOnline
        self.is_blocked = is_blocked
        self.mood = mood
        self.name = name
        self.number = number
        self.profile_pic = profile_pic
        self.username = username
        
    }
}
