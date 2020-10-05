//
//  SignInVM.swift
//  ConvexVchat
//
//  Created by Ovais Naveed on 9/7/20.
//  Copyright © 2020 n0. All rights reserved.
//

import Foundation
import UIKit

class SignInVM: NSObject {
    
    
    typealias signInCallBack = (_ status: Bool, _ message: String) -> Void
    typealias errorCallBack = (_ message: String) -> Void
    var signInCallback: signInCallBack?
    var errorCallback: errorCallBack?
    
    
    func SignInData(mobileNumber: String) {
        
        if mobileNumber.count != 0 {
            
            Login(mobileNumber: mobileNumber)
        } else {
           print(" Please enter mobileNUmber ") // First Name should not be empty
        }
        
    }
    
    fileprivate func Login(mobileNumber: String) {
        
         let params = ["mobile": mobileNumber]
        
        print("Params", params)
        AuthService.instance.logIn(MethodName: Constants.signIn, params: params, successCompletionHandler: { (response) in


            print("MVVM CHANGE NUMBER API RESPONSE", response)

            let responseCode = response["code"] as! Int

            switch responseCode{
            case 200:

                self.signInCallback?(true, "Success")

                print("Response is 200")
            case 400 :
                let message = response["message"]
                self.errorCallback?(message as! String)
                print("Error")
            default:
                print("")
            break

            }

        }) { (response: String) in
            self.signInCallback?(false, response)
            print("NON - Success reponse",response)
        }
        
    }
    
    func loginCompletionHandler(callback: @escaping signInCallBack){
        self.signInCallback = callback
    }
    
    func errorCompletionHandler(callback: @escaping errorCallBack){
        self.errorCallback = callback
    }
    
}
