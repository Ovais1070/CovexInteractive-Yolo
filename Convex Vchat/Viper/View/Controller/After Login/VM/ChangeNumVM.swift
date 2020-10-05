//
//  ChangeNumVM.swift
//  ConvexVchat
//
//  Created by Ovais Naveed on 9/4/20.
//  Copyright © 2020 n0. All rights reserved.
//

import Foundation
import UIKit

class ChangeNumVM: NSObject {
    
    
    typealias updateNumberCallBack = (_ status: Bool, _ message: String) -> Void
    var updateCallback: updateNumberCallBack?
    
    
    
    func PostNumber(newNumber: String, oldNumber: String) {
        
        if newNumber.count != 0 {
            if oldNumber.count != 0 {
                
                changeNumber(newNumber: newNumber, oldNumber: oldNumber)
            } else {
               print("New Number is empty ") // Last name should not be empty
            }
        } else {
           print(" Old Number is empty ") // First Name should not be empty
        }
        
    }
    
    fileprivate func changeNumber(newNumber: String, oldNumber: String) {
        
         let params = ["new_number": newNumber, "old_number": oldNumber]
        
        print("Params", params)
        AuthService.instance.ChangeNumber(MethodName: Constants.changeNumber, params: params, successCompletionHandler: { (response) in


            print("MVVM CHANGE NUMBER API RESPONSE", response)

            let responseCode = response["code"] as! Int

            switch responseCode{
            case 200:

                self.updateCallback?(true, "Updated Successfully")

                print("Response is 200")
            case 400 :
                print("Error")
            default:
                print("")
            break

            }

        }) { (response: String) in
            self.updateCallback?(false, response)
            print("NON - Success reponse",response)
        }
        
    }
    
    func updateNumberCompletionHandler(callback: @escaping updateNumberCallBack){
        self.updateCallback = callback
    }
    
    
}
