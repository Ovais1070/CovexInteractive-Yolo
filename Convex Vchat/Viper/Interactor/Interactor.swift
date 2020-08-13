//
//  Interactor.swift
//  User
//
//  Created by imac on 12/19/17.
//  Copyright © 2017 Appoets. All rights reserved.
//

import Foundation

class Interactor  {
    
    var webService: PostWebServiceProtocol?
    var presenter: PostPresenterOutputProtocol?
}

//MARK:- PostInteractorInputProtocol

extension Interactor : PostInteractorInputProtocol {
     
    
    func send(api: Base, url: String, data: Data?, type: HttpType) {
      
        self.webService?.retrieve(api: api,url: url, data: data, imageData: nil, paramters: nil, type: type, completion: nil)
    }
    
    func send(api: Base, data: Data?, paramters: [String : Any]?, type: HttpType) {
        self.webService?.retrieve(api: api,url: nil, data: data, imageData: nil, paramters: paramters, type: type, completion: nil)
    }
    
    func send(api: Base, imageData: [String : Data]?, parameters: [String : Any]?) {
        self.webService?.retrieve(api: api,url: nil, data: nil, imageData: imageData, paramters: parameters, type: .POST, completion: nil)
    }
}

//MARK:- PostInteractorOutputProtocol

extension Interactor : PostInteractorOutputProtocol {

    func on(api: Base, response: Data) {
        
        
        
        print("apibase",api.rawValue)
        switch api {
            
 
        case .phoneNumVerify:

            
            self.presenter?.senduserVerify(api: api, data: response)

            
        case  .signUp:
            
             
            self.presenter?.sendProfile(api: api, data: response)
            
            
        case .changePassword, .resetPassword, .cancelRequest, .payNow, .locationServicePostDelete, .addPromocode, .logout, .postCards, .deleteCard, .userVerify, .rateProvider, .updateRequest :
            
            
            
            
            self.presenter?.sendSuccess(api: api, data: response)
            
        case .forgotPassword:
            self.presenter?.sendUserData(api: api, data: response)
        
        
         
        default :
            break
            
        }
    }
    
    func on(api: Base, error: CustomError) {
        
        self.presenter?.onError(api: api, error: error)
    }
}

