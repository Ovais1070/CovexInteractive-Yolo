//
//  Network.swift
//  ConvexVchat
//
//  Created by Ovais Naveed on 8/12/20.
//  Copyright © 2020 n0. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
import SwiftyJSON



class AuthService {
    
    
    static let instance = AuthService()
    
    // USER VALIDATION
    
    func ImportContacts( MethodName: String, params : Parameters, successCompletionHandler: @escaping (NSDictionary) -> Swift.Void, failureCompletionHandler: @escaping (String) -> Swift.Void){
        let url = baseUrl + MethodName
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON { (response) in

        
                    switch response.result {
                        case let .success(value): return successCompletionHandler(value as! NSDictionary)
                    case let .failure(error): return failureCompletionHandler((error.localizedDescription))
                    }
          }
    }
    
    
    
}
