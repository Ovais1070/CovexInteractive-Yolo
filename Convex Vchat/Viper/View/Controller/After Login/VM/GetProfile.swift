//
//  GetProfile.swift
//  ConvexVchat
//
//  Created by Ovais Naveed on 8/19/20.
//  Copyright © 2020 n0. All rights reserved.
//

import Foundation

class GetProfile: NSObject {
    
    typealias getProfileCallBack = (_ status: Bool, _ message: String, _ response: NSDictionary) -> Void
//    typealias getresponseData = (_ response: NSDictionary) -> Void
    
    var profileCallback: getProfileCallBack?
//    var responseCallBack: getresponseData?
    
    
    
    func GetProfile(phone: String) {
        
        getProfileData(phone: phone)
    }
    
    
    
    
    fileprivate func getProfileData(phone: String) {
        
         let params = ["mobile": phone]
        
        AuthService.instance.UpdateProfile(MethodName: Constants.getProfile, params: params, successCompletionHandler: { (response) in
            
            print("MVVM EDIT PROFILE API RESPONSE", response)
            
            let responseCode = response["code"] as! Int
            
            switch responseCode{
            case 200:
                
                let message = response["message"] as! String
                let responseData = response["data"] as! NSDictionary
                
                
                self.profileCallback?(true, message, responseData)
                
                print("Response is 200")
            case 400 :
                print("Error")
            default:
                print("")
            break
           
            }
            
        }) { (response: String) in
            self.profileCallback?(false, response, ["":""])
            print("NON - Success reponse",response)
        }
        
    }
    
    func getProfileCompletionHandler(callback: @escaping getProfileCallBack){
        self.profileCallback = callback
    }
    
//    func responseProfileCompletionHandler(callback: @escaping getresponseData){
//        self.responseCallBack = callback
//    }
}
