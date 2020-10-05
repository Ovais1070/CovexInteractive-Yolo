//
//  CheckUserVM.swift
//  ConvexVchat
//
//  Created by Ovais Naveed on 9/9/20.
//  Copyright © 2020 n0. All rights reserved.
//

import Foundation
import UIKit

class CheckUserVM: NSObject {
    
    
    typealias checkUserCallBack = (_ status: Bool, _ message: String) -> Void
    var checkUserCallback: checkUserCallBack?
    
    
    
    
    func CheckUserData(mobileNumber: String) {
        
        if mobileNumber.count != 0 {
            
            checkUser(mobileNumber: mobileNumber)
        } else {
           print(" Please enter mobileNUmber ") // First Name should not be empty
        }
        
    }
    
    fileprivate func checkUser(mobileNumber: String) {
        
         let params = ["mobile": mobileNumber]
        
        print("Params", params)
        AuthService.instance.CheckUser(MethodName: Constants.checkUser, params: params, successCompletionHandler: { (response) in


            print("MVVM CHANGE NUMBER API RESPONSE", response)

            let responseCode = response["code"] as! Int

        
            switch responseCode{
            case 200:

                self.checkUserCallback?(true, "Success")

                print("Response is 200")
            case 400 :
                
                self.checkUserCallback?(false, "User Does not exist")
                print("Error")
            default:
                print("")
            break

            }

        }) { (response: String) in
            self.checkUserCallback?(false, response)
            print("NON - Success reponse",response)
        }
        
    }
    
    func checkUserCompletionHandler(callback: @escaping checkUserCallBack){
        self.checkUserCallback = callback
    }
    
    
}

