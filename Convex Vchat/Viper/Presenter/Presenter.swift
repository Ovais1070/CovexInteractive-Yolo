//
//  Presenter.swift
//  User
//
//  Created by imac on 12/19/17.
//  Copyright © 2017 Appoets. All rights reserved.
//

import Foundation


class Presenter  {
    
    var interactor: PostInteractorInputProtocol?
    var controller: PostViewProtocol?
}

//MARK:- Implementation PostPresenterInputProtocol

extension Presenter : PostPresenterInputProtocol {

    func put(api: Base, url: String, data: Data?) {
        interactor?.send(api: api, url: url, data: data, type: .PUT)
    }
    
    func delete(api: Base, url: String, data: Data?) {
        interactor?.send(api: api, url: url, data: data, type: .DELETE)
    }
    
    func patch(api: Base, url: String, data: Data?) {
        interactor?.send(api: api, url: url, data: data,type: .PATCH)
    }
    
    func post(api: Base, data: Data?) {
        interactor?.send(api: api, data: data, paramters: nil, type: .POST)
    }
    
    func get(api: Base, parameters: [String : Any]?) {
        interactor?.send(api: api, data: nil, paramters: parameters, type: .POST)
    }
    
    func get(api : Base, url : String){
        interactor?.send(api: api, url: url, data: nil, type: .GET)
    }
    
    func post(api: Base, imageData: [String : Data]?, parameters: [String : Any]?) {
        interactor?.send(api: api, imageData: imageData, parameters: parameters)
    }
    
    func post(api: Base, url: String, data: Data?) {
        interactor?.send(api: api, url: url, data: data,type: .POST)
    }
    
}


//MARK:- Implementation PostPresenterOutputProtocol

extension Presenter : PostPresenterOutputProtocol {
     
    
     
     
    
     
    func sendUserData(api: Base, data: Data) {
        
      
        controller?.getUserData(api: api, data: PresenterProcessor.shared.userData(data: data))
    }
    
    func onError(api: Base, error: CustomError) {
        
        controller?.onError(api: api, message: error.localizedDescription , statusCode: error.statusCode)
    }
    

    
    func sendProfile(api: Base, data: Data) {
        
        
        controller?.getProfile(api: api, data: PresenterProcessor.shared.profile(data: data))
    }
    
    
    
    func senduserVerify(api: Base, data: Data) {
        
        
        controller?.getUserVerData(api: api, data: PresenterProcessor.shared.verUser(data: data))
    }
    
    func sendSuccess(api: Base, data: Data) {
        controller?.success(api: api, message: PresenterProcessor.shared.success(api: api, response: data))
    }
    
     
    
    
    
}


