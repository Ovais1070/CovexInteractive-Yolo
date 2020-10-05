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
    
    
    
    func logIn( MethodName: String, params : Parameters, successCompletionHandler: @escaping (NSDictionary) -> Swift.Void, failureCompletionHandler: @escaping (String) -> Swift.Void){
        let url = baseUrl + MethodName
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON { (response) in

            
            
                
                
            
            
        
                    switch response.result {
                        case let .success(value): return successCompletionHandler(value as! NSDictionary)
                    case let .failure(error): return failureCompletionHandler((error.localizedDescription))
                    }
          }
    }
    
    
    
    
    
    func GetOTP( MethodName: String, params : Parameters, successCompletionHandler: @escaping (Data) -> Swift.Void, failureCompletionHandler: @escaping (String) -> Swift.Void){
            let url = baseUrl + MethodName
            
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseData(completionHandler: { (response) in
                
                
    //            let dict : NSDictionary = response.result.value! as! NSDictionary

                 print("Dict Dict Dict Dict")
                 switch response.result {
                 case let .success(value): return successCompletionHandler((value as NSData) as Data)
                 case let .failure(error): return failureCompletionHandler((error.localizedDescription))
                
                 
                 }
            })
    }
    
    
    func SendOTP( MethodName: String, params : Parameters, successCompletionHandler: @escaping (NSDictionary) -> Swift.Void, failureCompletionHandler: @escaping (String) -> Swift.Void){
        let url = baseUrl + MethodName
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON { (response) in

            
            
                
                
            
            
        
                    switch response.result {
                        case let .success(value): return successCompletionHandler(value as! NSDictionary)
                    case let .failure(error): return failureCompletionHandler((error.localizedDescription))
                    }
          }
    }

    
    func CheckUser( MethodName: String, params : Parameters, successCompletionHandler: @escaping (NSDictionary) -> Swift.Void, failureCompletionHandler: @escaping (String) -> Swift.Void){
        let url = baseUrl + MethodName
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON { (response) in

            
            
                
                
            
            
        
                    switch response.result {
                        case let .success(value): return successCompletionHandler(value as! NSDictionary)
                    case let .failure(error): return failureCompletionHandler((error.localizedDescription))
                    }
          }
    }
    
    
    func RegisterUser( MethodName: String, params : Parameters, successCompletionHandler: @escaping (NSDictionary) -> Swift.Void, failureCompletionHandler: @escaping (String) -> Swift.Void){
        let url = baseUrl + MethodName
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON { (response) in

            
            
                
                
            
            
        
                    switch response.result {
                        case let .success(value): return successCompletionHandler(value as! NSDictionary)
                    case let .failure(error): return failureCompletionHandler((error.localizedDescription))
                    }
          }
    }
    
    func ImportContacts( MethodName: String, params : Parameters, successCompletionHandler: @escaping (NSDictionary) -> Swift.Void, failureCompletionHandler: @escaping (String) -> Swift.Void){
        let url = baseUrl + MethodName
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON { (response) in

        
                    switch response.result {
                        case let .success(value): return successCompletionHandler(value as! NSDictionary)
                    case let .failure(error): return failureCompletionHandler((error.localizedDescription))
                    }
          }
    }
    
    
    
    func VerificationCode( MethodName: String, params : Parameters, successCompletionHandler: @escaping (Data) -> Swift.Void, failureCompletionHandler: @escaping (String) -> Swift.Void){
        let url = baseUrl + MethodName
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseData(completionHandler: { (response) in
            
            
//            let dict : NSDictionary = response.result.value! as! NSDictionary

             print("Dict Dict Dict Dict")
             switch response.result {
             case let .success(value): return successCompletionHandler((value as NSData) as Data)
             case let .failure(error): return failureCompletionHandler((error.localizedDescription))
            
             
             }
        })
    }
    
    
    
    
    func UpdateProfile( MethodName: String, params : Parameters, successCompletionHandler: @escaping (NSDictionary) -> Swift.Void, failureCompletionHandler: @escaping (String) -> Swift.Void){
        let url = baseUrl + MethodName
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON { (response) in

            
            
                
                
            
            
        
                    switch response.result {
                        case let .success(value): return successCompletionHandler(value as! NSDictionary)
                    case let .failure(error): return failureCompletionHandler((error.localizedDescription))
                    }
          }
    }
    
    
    
    
    
    func UploadProfile( MethodName: String, imageData: UIImage, params : Parameters, successCompletionHandler: @escaping (NSDictionary) -> Swift.Void, failureCompletionHandler: @escaping (String) -> Swift.Void){
           let url = baseUrl + MethodName
        let imgData = imageData.jpegData(compressionQuality: 0.2)!
        
         Alamofire.upload(
                        multipartFormData: { multipartFormData in
                                   
        
                            multipartFormData.append(imgData, withName: "profile_pic", fileName: "file"+"."+"jpg", mimeType: "fileimage/jpg")
                            
                            for (key, value) in params {
        
                                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
        
                            }
                    },
                        to:url,
                        encodingCompletion:
                        { encodingResult in
        
                            switch encodingResult
                            {
                            case .success(let upload, _, _):
                                upload.responseJSON
                                    { response in
                                        switch response.result
                                        {
                                        case .success(let JSON):
                                            print(JSON)
        
                                            return
                                        case .failure(let error):
                                            print(error)
                                           
                                        }
                                }
                            case .failure(let encodingError):
                                print(encodingError)
                           }
                    }
        
        
                    );
        
       }
    

    func ChangeNumber( MethodName: String, params : Parameters, successCompletionHandler: @escaping (NSDictionary) -> Swift.Void, failureCompletionHandler: @escaping (String) -> Swift.Void){
        let url = baseUrl + MethodName
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON { (response) in

            
            
                
                
            
            
        
                    switch response.result {
                        case let .success(value): return successCompletionHandler(value as! NSDictionary)
                    case let .failure(error): return failureCompletionHandler((error.localizedDescription))
                    }
          }
    }
    
    func Logout( MethodName: String, params : Parameters, successCompletionHandler: @escaping (NSDictionary) -> Swift.Void, failureCompletionHandler: @escaping (String) -> Swift.Void){
        let url = baseUrl + MethodName
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON { (response) in

            
            
                
                
            
            
        
                    switch response.result {
                        case let .success(value): return successCompletionHandler(value as! NSDictionary)
                    case let .failure(error): return failureCompletionHandler((error.localizedDescription))
                    }
          }
    }
    
}
