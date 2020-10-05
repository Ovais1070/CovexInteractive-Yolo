//
//  RegisterVM.swift
//  ConvexVchat
//
//  Created by Ovais Naveed on 9/10/20.
//  Copyright © 2020 n0. All rights reserved.
//

import Foundation
import UIKit

class RegisterVM: NSObject {
    
    
    typealias registerCallBack = (_ status: Bool, _ message: String) -> Void
    var registerCallback: registerCallBack?
    
    
    
    
    func RegisterUser(mobileNumber: String, first_name: String, last_name: String, dob: String) {
        
        if mobileNumber.count != 0 {
            
            register(mobileNumber: mobileNumber, first_name: first_name, last_name: last_name, dob: dob)
        } else {
           print(" Please enter mobileNUmber ") // First Name should not be empty
        }
        
    }
    
    fileprivate func register(mobileNumber: String, first_name: String, last_name: String, dob: String) {
        
        let params = ["mobile": mobileNumber, "first_name": first_name, "last_name": last_name, "dob": dob]
        
        print("Params", params)
        AuthService.instance.RegisterUser(MethodName: Constants.register, params: params, successCompletionHandler: { (response) in


            print("MVVM CHANGE NUMBER API RESPONSE", response)

            let responseCode = response["code"] as! Int

        
            switch responseCode{
            case 200:

                self.registerCallback?(true, "Success")

                print("Response is 200")
            case 400 :
                
                self.registerCallback?(false, "User Does not exist")
                print("Error")
            default:
                print("")
            break

            }

        }) { (response: String) in
            self.registerCallback?(false, response)
            print("NON - Success reponse",response)
        }
        
    }
    
    func registerCompletionHandler(callback: @escaping registerCallBack){
        self.registerCallback = callback
    }
    
    
}


