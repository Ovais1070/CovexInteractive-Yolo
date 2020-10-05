//
//  VarificationVM.swift
//  ConvexVchat
//
//  Created by Ovais Naveed on 9/8/20.
//  Copyright © 2020 n0. All rights reserved.
//

import Foundation
import UIKit

class SendOTPVM: NSObject {
    
    
    typealias sendOTPCallBack = (_ status: Bool, _ message: String) -> Void
    var sendOTPCallback: sendOTPCallBack?
    
    
    
    
    func sendOtpData(mobileNumber: String) {
        
        if mobileNumber.count != 0 {
            
            sendOtp(mobileNumber: mobileNumber)
        } else {
           print(" Please enter mobileNUmber ") // First Name should not be empty
        }
        
    }
    
    fileprivate func sendOtp(mobileNumber: String) {
        
         let params = ["mobile": mobileNumber]
        
        print("Params", params)
        AuthService.instance.SendOTP(MethodName: Constants.signInOtp, params: params, successCompletionHandler: { (response) in


            print("MVVM CHANGE NUMBER API RESPONSE", response)

            let responseCode = response["code"] as! Int

        
            switch responseCode{
            case 200:

                self.sendOTPCallback?(true, "Success")

                print("Response is 200")
            case 400 :
                
                print("Error")
            default:
                print("")
            break

            }

        }) { (response: String) in
            self.sendOTPCallback?(false, response)
            print("NON - Success reponse",response)
        }
        
    }
    
    func sendOTPCompletionHandler(callback: @escaping sendOTPCallBack){
        self.sendOTPCallback = callback
    }
    
    
}
