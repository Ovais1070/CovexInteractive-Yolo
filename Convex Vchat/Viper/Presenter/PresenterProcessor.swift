//
//  PresenterProcessor.swift
//  User
//
//  Created by imac on 1/1/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import Foundation

class PresenterProcessor {

    static let shared = PresenterProcessor()

    func success(api : Base, response : Data)->String? {
        
        return response.getDecodedObject(from: DefaultMessage.self)?.message
    }
    
    //  Send Oath
    
//    func loginRequest(data : Data)->LoginRequest? {
//        return data.getDecodedObject(from: LoginRequest.self)
//    }
    
    func verUser(data : Data)->VerifyUser? {
        
       
        return data.getDecodedObject(from: VerifyUser.self)
        
        
    }
    
    // Send Profile
    
    func profile(data : Data)->Profile? {
        
        
        
        return data.getDecodedObject(from: Profile.self)
        
        
    }
    
    //  UserData
    
    func userData(data : Data)->UserDataResponse? {
        return data.getDecodedObject(from: ForgotResponse.self)?.user
    }
    
     
    
    
    
     
    //  Notification
    
//    func notifications(data : Data)->[NotificationManagerModel]? {
//
//        return data.getDecodedObject(from: [NotificationManagerModel].self)
//    }
    
     
}






