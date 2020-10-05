//
//  EditProfileVM.swift
//  ConvexVchat
//
//  Created by Ovais Naveed on 8/19/20.
//  Copyright © 2020 n0. All rights reserved.
//

import Foundation
import UIKit

class EditProfileVM: NSObject {
    
    
    typealias updateProfileCallBack = (_ status: Bool, _ message: String) -> Void
    var profileCallback: updateProfileCallBack?
    
    
    
    func PostProfile(uploadFile: UIImage , firstName: String, lastName: String, country: String, phone: String, email: String, address: String, website: String) {
        
        if firstName.count != 0 {
            if lastName.count != 0 {
                if phone.count != 0 {
                    if email.count != 0 {
                        if address.count != 0 {
                            if website.count != 0 {
                                sendProfileData(profilePic: uploadFile, firstName: firstName, lastName: lastName, country: country, phone: phone, email: email, address: address, website: website)
                            } else {
                                print(" website should not be empty ") // website should not be empty
                            }
                        } else {
                          print(" address should not be empty ")  // address should not be empty
                        }
                    } else {
                       print(" email should not be empty ") // email should not be empty
                    }
                } else {
                   print(" one should not be empty ") // phone should not be empty
                }
            } else {
               print(" Last name should not be empty ") // Last name should not be empty
            }
        } else {
           print(" First Name should not be empty ") // First Name should not be empty
        }
        
    }
    
    fileprivate func sendProfileData(profilePic:UIImage, firstName: String, lastName: String, country: String, phone: String, email: String, address: String, website: String ) {
        
         let params = ["mobile": phone, "first_name": firstName, "last_name": lastName, "email":email, "address": address]
        
        AuthService.instance.UploadProfile(MethodName: Constants.updateUserProfile, imageData: profilePic, params: params, successCompletionHandler: { (response) in
            
            print("MVVM EDIT PROFILE API RESPONSE", response)
            
            let responseCode = response["code"] as! Int
            
            switch responseCode{
            case 200:
                
                self.profileCallback?(true, "Updated Successfully")
                
                print("Response is 200")
            case 400 :
                print("Error")
            default:
                print("")
            break
           
            }
            
        }) { (response: String) in
            self.profileCallback?(false, response)
            print("NON - Success reponse",response)
        }
        
    }
    
    func updateProfileCompletionHandler(callback: @escaping updateProfileCallBack){
        self.profileCallback = callback
    }
    
    
}
