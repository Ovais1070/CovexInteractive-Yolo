//
//  DPKWebServiceOperation.swift
//  JobPortal
//
//  Created by samyotech on 17/08/17.
//  Copyright © 2017 samyotech. All rights reserved.
//

//import Foundation
import UIKit
import Alamofire


import SwiftyJSON
//import PKHUD

 protocol DPKWebOperationDelegate {
    
    func callBackSuccessResponseData(dictResponse: Data)

    func callBackSuccessResponse(dictResponse: [String:Any])
      func callBackFailResponse(dictResponse: [String:Any])
}

class DPKWebOperation: NSObject  {
    
    static var operation_delegate:DPKWebOperationDelegate?
    
    //MARK:- Simple Web Service Calling Post
    static func WebServiceCalling(vc: UIViewController, dictPram: [String: Any], methodName: String) {
        
        //CHECK REACHABILITY
        let onjRechability: NetworkReachabilityManager = NetworkReachabilityManager()!
        
        if onjRechability.isReachable {
            //True
            //SHOW Loader
            //            HUD.show(.progress)
            
            //URL
            let strUrl = String(format: "%@%@",baseUrl, methodName)
            
            print(strUrl, "\n",dictPram)
            
            // MAKE REQUEST
            Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = 300
            
            Alamofire.request(strUrl, method: .post, parameters: dictPram, encoding: URLEncoding.default).responseJSON { (responseData) in
                
                //Hide Loader
                print(responseData.result)
                print(responseData)
                
                if((responseData.result.value) != nil) {
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    print(swiftyJsonVar)
                    
                    //SAVE USER DETAIL DEFAULT
                    let dict : NSDictionary = responseData.result.value! as! NSDictionary
                    
                   // let responseData = responseData

                    let vc_C = vc
                    if  dict["status"] as! NSNumber == 3
                    {
                        
                        
                        
                        // Alert.show(vc: vc, titleStr: "Message", messageStr:(dict["message"] as? String)!)
//                        loader.hideLoader()
                        
                        
                        
                         
                            
                           
                        
                      //  vc_C.present(alert, animated: true, completion: nil)
                        
                    }
                    if  dict["status"] as! NSNumber == 1
                    {
                        
                        
                        
 
                        
                        operation_delegate?.callBackSuccessResponseData(dictResponse: responseData.data!)
 
                        operation_delegate?.callBackSuccessResponse(dictResponse: dict as! [String : Any])
                    }else if  dict["status"] as! NSNumber == 0
                    {
                        operation_delegate?.callBackFailResponse(dictResponse: dict as! [String : Any])
                        operation_delegate?.callBackSuccessResponseData(dictResponse: responseData.data!)

                    }
                    else
                    {
                        operation_delegate?.callBackSuccessResponseData(dictResponse: responseData.data!)

                        //CallBack Fail
                        operation_delegate?.callBackFailResponse(dictResponse: dict as! [String : Any])
                    }
                    
                }else{
                    //SHOW DPK Loader
//                    loader.hideLoader()
                    
                    //Alert Message for Server Error
                    // Alert.show(vc: vc, titleStr: "Server Error", messageStr: Alert.kServer_Error)
                }
            }
            
        }else{
            print("not reachable")
            //Alert Message for Network Error
//            Alert.show(vc: vc, titleStr: "Network Error", messageStr: Alert.kNetwork_Error)
//            loader.hideLoader()
        }
    }
    
    
    //MARK:- Simple Web Service Calling Get
    static func WebServiceCallingGet(vc: UIViewController, dictPram: [String: Any], methodName: String) {
        
        //CHECK REACHABILITY
        let onjRechability: NetworkReachabilityManager = NetworkReachabilityManager()!
        
        if onjRechability.isReachable {
            //True
            
            //URL
            let strUrl = String(format: "%@%@", "Constant.kBase_Url", methodName)
            
            print(strUrl, "\n",dictPram)
            
            // MAKE REQUEST
            Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = 300
            
            Alamofire.request(strUrl, method: .get, parameters: dictPram, encoding: URLEncoding.default).responseJSON { (responseData) in
                
                print(responseData.result)
                print(responseData)
                
                if((responseData.result.value) != nil) {
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    print(swiftyJsonVar)
                    
                    //SAVE USER DETAIL DEFAULT
                    let dict : NSDictionary = responseData.result.value! as! NSDictionary
                    let vc_C = vc
                    if  dict["status"] as! NSNumber == 3
                    {
                        
                        
                        
                        // Alert.show(vc: vc, titleStr: "Message", messageStr:(dict["message"] as? String)!)
                      //  loader.hideLoader()
                        
                        
                        
                         
                        
                        
                    }
                    if  dict["status"] as! NSNumber == 1
                    {
                        operation_delegate?.callBackSuccessResponse(dictResponse: dict as! [String : Any])
                    }else if  dict["status"] as! NSNumber == 0
                    {
                        operation_delegate?.callBackFailResponse(dictResponse: dict as! [String : Any])
                    }
                    else
                    {
                        //CallBack Fail
                        operation_delegate?.callBackFailResponse(dictResponse: dict as! [String : Any])
                    }
                    
                }else{
                    //SHOW DPK Loader
                   
                    // loader.hideLoader()
                    //Alert Message for Server Error
                   // Alert.show(vc: vc, titleStr: "Server Error", messageStr: Alert.kServer_Error)
                    // loader.hideLoader()
                }
            }
            
            
        }else{
            print("not reachable")
            //Alert Message for Network Error
            // loader.hideLoader()
            Alert.show(vc: vc, titleStr: "Network Error", messageStr: Alert.kNetwork_Error)
        }
    }
    
    
    //MARK:- Multipath Image Web Service Calling with Parameter
    static func WebServiceCallingWithImage(vc: UIViewController, dictPram: [String: Any], methodName: String, img_pram: String, imageUpload: UIImage) {
       
        //CHECK REACHABILITY
        let onjRechability: NetworkReachabilityManager = NetworkReachabilityManager()!
        
        if onjRechability.isReachable {
        
            //SHOW HUD
//            HUD.show(.progress)
       
            let strUrl = String(format: "%@%@", baseUrl, methodName)
            print(strUrl)
            
            upload(multipartFormData: { (MultipartFormData) in
                
                if let data = imageUpload.pngData() as NSData? {
                    MultipartFormData.append(data as Data, withName: img_pram, fileName: "file.png", mimeType: "image/jpeg")
                }
                
                
                for (key, value) in dictPram
                {
                    MultipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key);
                }
                
            }, to: strUrl,
               encodingCompletion: { (result) in
                
                switch result {
                case .success(let upload, _, _):
                    
                    upload.responseJSON { response in
//                        HUD.hide()

                        
                        if let dict: NSDictionary = response.result.value as? NSDictionary {
                            
                            let vc_C = vc
                            if  dict["status"] as! NSNumber == 3
                            {
                                
                                
                                
                               Alert.show(vc: vc, titleStr: "Message", messageStr:(dict["message"] as? String)!)
                             //   loader.hideLoader()
                                
                                
                            
                                
                            }
                            if  dict["status"] as! NSNumber == 1
                            {
                                operation_delegate?.callBackSuccessResponse(dictResponse: dict as! [String : Any])
                            }else if  dict["status"] as! NSNumber == 0
                            {
                                operation_delegate?.callBackFailResponse(dictResponse: dict as! [String : Any])
                            }
                            else
                            {
                                //CallBack Fail
                                operation_delegate?.callBackFailResponse(dictResponse: dict as! [String : Any])
                            }
                            
                        }else{
                            //Alert Message for Server Error
//                            loader.hideLoader()

                           // Alert.show(vc: vc, titleStr: "Server Error", messageStr: Alert.kServer_Error)
                        }
                        
                    }
                    
                case .failure:
                    //SHOW DPK Loader
//                    loader.hideLoader()
                    
                    //Alert Message for Server Error
                   // Alert.show(vc: vc, titleStr: "Server Error", messageStr: Alert.kServer_Error)
                    break
                }
            })
            
        }else{
            print("not reachable")
            //Alert Message for Network Error
//             loader.hideLoader()
            Alert.show(vc: vc, titleStr: "Network Error", messageStr: Alert.kNetwork_Error)
        }
    }
    //MARK:- Simple Web Service Calling Post
    static func WebServiceCallingWithOutLoader(vc: UIViewController, dictPram: [String: String], methodName: String) {
        
        //CHECK REACHABILITY
        let onjRechability: NetworkReachabilityManager = NetworkReachabilityManager()!
        
        if onjRechability.isReachable {
            //True
            //SHOW Loader
            //            HUD.show(.progress)
            
            //URL
            let strUrl = String(format: "%@%@", baseUrl, methodName)
            
            print(strUrl, "\n",dictPram)
            
            // MAKE REQUEST
            Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = 300
            
            Alamofire.request(strUrl, method: .post, parameters: dictPram, encoding: URLEncoding.default).responseJSON { (responseData) in
                
                //Hide Loader
                print(responseData.result)
                print(responseData)
                
                if((responseData.result.value) != nil) {
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    print(swiftyJsonVar)
                    
                    //SAVE USER DETAIL DEFAULT
                    let dict : NSDictionary = responseData.result.value! as! NSDictionary
                    let vc_C = vc
                    if  dict["status"] as! NSNumber == 3
                    {
                        
                        
                        
                          Alert.show(vc: vc, titleStr: "Message", messageStr:(dict["message"] as? String)!)
                        
                        
                         
                        
                    }
                    if  dict["status"] as! NSNumber == 1
                    {
                        operation_delegate?.callBackSuccessResponse(dictResponse: dict as! [String : Any])
                    }else if  dict["status"] as! NSNumber == 0
                    {
                        operation_delegate?.callBackFailResponse(dictResponse: dict as! [String : Any])
                    }
                    else
                    {
                        //CallBack Fail
                        operation_delegate?.callBackFailResponse(dictResponse: dict as! [String : Any])
                    }
                    
                }else{
                    //SHOW DPK Loader
                    
                    //Alert Message for Server Error
                    // Alert.show(vc: vc, titleStr: "Server Error", messageStr: Alert.kServer_Error)
                }
            }
            
        }else{
            print("not reachable")
            //Alert Message for Network Error
        }
    }
    
 }


