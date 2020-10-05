//
//  GetOTPVM.swift
//  ConvexVchat
//
//  Created by Ovais Naveed on 9/8/20.
//  Copyright © 2020 n0. All rights reserved.
//

import Foundation
import UIKit

class GetOTPVM: NSObject {
    
    
    typealias getOTPCallBack = (_ data: Data, _ status: Bool, _ message: String) -> Void
    typealias errorCallBack = (_ message: String) -> Void
    var getOTPCallback: getOTPCallBack?
    var errorCallback: errorCallBack?
    
    
    
    func getOtpData(mobileNumber: String, code: String) {
        
        if mobileNumber.count != 0 {
            
            getOtp(mobileNumber: mobileNumber, code: code)
        } else {
           print(" Please enter mobileNUmber ") // First Name should not be empty
        }
        
    }
    
    fileprivate func getOtp(mobileNumber: String, code: String) {
        
        let params = ["mobile": mobileNumber, "code": code]
        
        print("Params", params)
        AuthService.instance.GetOTP(MethodName: Constants.getOtp, params: params, successCompletionHandler: { (response) in


            print("MVVM Get OTP API RESPONSE", response)


            do {
                let dictionary = try JSONSerialization.jsonObject(with: response as Data, options: JSONSerialization.ReadingOptions()) as! NSDictionary

                print("dictionarydictionary", dictionary)

                let responseCode = dictionary["code"] as! Int

                                        switch responseCode{
                                        case 200:
                                            self.getOTPCallback?(response, true, "Success")

                                            print("Response is 200")
                                        case 400 :
                                            let message = dictionary["message"]
                                            self.errorCallback?(message as! String)
                                            print("Error")
                                        default:
                                            print("")
                                        break



                                        }

               }
            catch {

                     }
            
        }) { (response: String) in
            
            print("NON - Success reponse",response)
        }
        
    }
    
    func getOTPCompletionHandler(callback: @escaping getOTPCallBack){
        self.getOTPCallback = callback
    }
    
    func errorCompletionHandler(callback: @escaping errorCallBack){
        self.errorCallback = callback
    }
}

