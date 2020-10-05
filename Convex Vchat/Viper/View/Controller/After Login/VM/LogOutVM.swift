//
//  LogOutVM.swift
//  ConvexVchat
//
//  Created by Ovais Naveed on 9/7/20.
//  Copyright © 2020 n0. All rights reserved.
//

import Foundation
import UIKit

class LogoutVM: NSObject {
    
    
    typealias logoutCallBack = (_ status: Bool, _ message: String) -> Void
    var logoutCallback: logoutCallBack?
    
    
    
    func Logout(mobileNumber: String) {
        
        if mobileNumber.count != 0 {
            logoutApi(mobileNumber: mobileNumber)
        }
        
    }
    
    fileprivate func logoutApi(mobileNumber: String) {
        
         let params = ["mobile": mobileNumber]
        
        print("Params", params)
        AuthService.instance.Logout(MethodName: Constants.logout, params: params, successCompletionHandler: { (response) in


            print("MVVM EDIT PROFILE API RESPONSE", response)

            let responseCode = response["code"] as! Int

            switch responseCode{
            case 200:

                self.logoutCallback?(true, "Updated Successfully")

                print("Response is 200")
            case 400 :
                print("Error")
            default:
                print("")
            break

            }

        }) { (response: String) in
            self.logoutCallback?(false, response)
            print("NON - Success reponse",response)
        }
        
    }
    
    func logoutCompletionHandler(callback: @escaping logoutCallBack){
        self.logoutCallback = callback
    }
    
    
}

