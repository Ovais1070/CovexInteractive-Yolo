//
//  Global.swift
//  Convex Vchat
//
//  Created by 1234 on 6/11/20.
//  Copyright © 2020 n0. All rights reserved.
//

import UIKit
import Foundation
import AudioUnit

var currentBundle : Bundle!
internal func initializeUserData()->User
{
    return User()
}


 
internal func storeInUserDefaults(){
    
    let data = NSKeyedArchiver.archivedData(withRootObject: User.main)
    UserDefaults.standard.set(data, forKey: Keys.list.userData)
    let groupDefaults = UserDefaults(suiteName: Keys.list.appGroup)
    groupDefaults?.set(true, forKey: Keys.list.isLoggedIn)
    UserDefaults.standard.synchronize()
     groupDefaults?.synchronize()
    print("Store in UserDefaults--", UserDefaults.standard.value(forKey: Keys.list.userData) ?? "Failed")
}

// Retrieve from UserDefaults
internal func retrieveUserData()->Bool{
    
    if let data = UserDefaults.standard.object(forKey: Keys.list.userData) as? Data, let userData = NSKeyedUnarchiver.unarchiveObject(with: data) as? User {
        User.main = userData
        
     }
    return User.main.last_name != nil
    
    
}
//MARK:- ShowLoader

internal func createActivityIndicator(_ uiView : UIView)->UIView{
    
    let container: UIView = UIView(frame: CGRect.zero)
    container.layer.frame.size = uiView.frame.size
    container.center = CGPoint(x: uiView.bounds.width/2, y: uiView.bounds.height/2)
    container.backgroundColor = UIColor(white: 0.2, alpha: 0.3)
    
    let loadingView: UIView = UIView()
    loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    loadingView.center = container.center
    loadingView.backgroundColor = .primary//UIColor(white:0.1, alpha: 0.7)
    loadingView.clipsToBounds = true
    loadingView.layer.cornerRadius = 10
    loadingView.layer.shadowRadius = 5
    loadingView.layer.shadowOffset = CGSize(width: 0, height: 4)
    loadingView.layer.opacity = 2
    loadingView.layer.masksToBounds = false
    loadingView.layer.shadowColor = UIColor.gray.cgColor
    
    let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    actInd.clipsToBounds = true
    actInd.style = .whiteLarge
    
    actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
    loadingView.addSubview(actInd)
    container.addSubview(loadingView)
    container.isHidden = true
    uiView.addSubview(container)
    actInd.startAnimating()
    
    return container
    
}

// Clear UserDefaults
internal func clearUserDefaults(){
    
    User.main = initializeUserData()  // Clear local User Data
    UserDefaults.standard.set(nil, forKey: Keys.list.userData)
    let groupDefaults = UserDefaults(suiteName: Keys.list.appGroup)
    groupDefaults?.set(false, forKey: Keys.list.isLoggedIn)
    UserDefaults.standard.removeVolatileDomain(forName: Bundle.main.bundleIdentifier!)
    UserDefaults.standard.synchronize()
    groupDefaults?.synchronize()
    print("Clear UserDefaults--", UserDefaults.standard.value(forKey: Keys.list.userData) ?? "Success")
    
}
internal func isFrom(isFromVC : String)->String{
    
    return isFromVC
}

func vibrate(with vibration : Vibration) {
    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
}
