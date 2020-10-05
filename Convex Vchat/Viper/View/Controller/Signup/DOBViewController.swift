//
//  DOBViewController.swift
//  Convex Vchat
//
//  Created by 1234 on 6/13/20.
//  Copyright © 2020 n0. All rights reserved.
//

import UIKit

class DOBViewController: UITableViewController {

    var window: UIWindow?
    
    @IBOutlet weak var dobPicker: UIDatePicker!
    var dob = ""
    let registerVM = RegisterVM()
    override func viewDidLoad() {
        super.viewDidLoad()

        dobPicker.datePickerMode = .date
        
    }
    
    
    

}
// MARK:- ApiCallRespose


extension DOBViewController : PostViewProtocol  {
    func onError(api: Base, message: String, statusCode code: Int) {
         
    }
    
    
    
    
    func getProfile(api: Base, data: Profile?) {
           
          // loader.isHideInMainThread(true)
           
           if api == .signUp  {
               Common.storeUserData(from: data)
               storeInUserDefaults()
               
               
               
             //  self.navigationController?.present(Common.setDrawerController(), animated: true, completion: nil)
               //self.presenter?.get(api: .getProfile, parameters: nil)
               //self.presenter?.post(api: .login, data: MakeJson.login(withUser: userInfo?.email,password:userInfo?.password))
               return
               
           }
           /*else if api == .getProfile {
            Common.storeUserData(from: data)
            storeInUserDefaults()
            self.navigationController?.present(id: Storyboard.Ids.DrawerController, animation: true)
            } else {
            loader.isHideInMainThread(true)
            } */
       }
    
    
    @IBAction func nextBtnTapped(sender : UIButton){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        self.dob = formatter.string(from: dobPicker.date)
        self.view.endEditing(true)
        print("DateDateDate", dob)
        let mobile = User.main.mobile!
        let firstName = User.main.first_name!
        let lastName = User.main.last_name!
        
        registerVM.RegisterUser(mobileNumber: mobile, first_name: firstName, last_name: lastName, dob: dob)
        
        registerVM.registerCompletionHandler { (status, message) in
            if status {
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let  mainView = UIStoryboard(name:"Main", bundle: nil)
                let viewcontroller : UIViewController = mainView.instantiateViewController(withIdentifier: "NavigationVC") as! NavigationVC
                appDelegate.window!.rootViewController = viewcontroller
                
                self.view.makeToast(message)
            } else {
                self.view.makeToast(message)
            }
        }
        
//        presenter?.get(api: .signUp, parameters: [Keys.list.firstName : User.main.first_name ?? "",Keys.list.lastName : User.main.last_name ?? "",Keys.list.mobile : User.main.mobile ?? "", Keys.list.dob : User.main.dob ?? ""])
//
//
//        self.view.endEditingForce()
     
 
                    
     
        }
   
}
