//
//  Router.swift
//  Convex Vchat
//
//  Created by 1234 on 6/10/20.
//  Copyright © 2020 n0. All rights reserved.
//

import Foundation
import UIKit


class Router {
    
    static let main = UIStoryboard(name: "Main", bundle: Bundle.main)
//    static let user = UIStoryboard(name: "User", bundle: Bundle.main)
    
    class func setWireFrame()->(UIViewController){
        
        let presenter : PostPresenterInputProtocol&PostPresenterOutputProtocol = Presenter()
        let interactor : PostInteractorInputProtocol&PostInteractorOutputProtocol = Interactor()
        let webService : PostWebServiceProtocol = Webservice()
        if let view : (PostViewProtocol & UIViewController) = main.instantiateViewController(withIdentifier: Storyboard.Ids.LaunchViewController) as? ViewController {
        
            presenter.controller = view
            view.presenter = presenter
            presenterObject = view.presenter
            
        }
        
        webService.interactor = interactor
        interactor.webService = webService
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        return retrieveUserData() ? Common.setAfterLoginController() : {
            let vc = main.instantiateViewController(withIdentifier: Storyboard.Ids.LaunchViewController)
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.isNavigationBarHidden = false
            
            return navigationController
      }()
    }
}
