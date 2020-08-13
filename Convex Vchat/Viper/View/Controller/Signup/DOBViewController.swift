//
//  DOBViewController.swift
//  Convex Vchat
//
//  Created by 1234 on 6/13/20.
//  Copyright © 2020 n0. All rights reserved.
//

import UIKit

class DOBViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
        
        
        
//        let code = countryText.text?.replacingOccurrences(of: "+", with: "")
//        let mobileNo = "\(code!)\(phoneNumber.text!)"
        
        
        presenter?.get(api: .signUp, parameters: [Keys.list.firstName : User.main.first_name ?? "",Keys.list.lastName : User.main.last_name ?? "",Keys.list.mobile : User.main.mobile ?? "", Keys.list.dob : User.main.dob ?? ""])
//
//
//
//        sender.view.addPressAnimation()
        self.view.endEditingForce()
     
          
        
        
        
        
            
            
           // self.present(id: Storyboard.Ids.MobileNoViewController, animation: true)
             
    //        userInfo =  MakeJson.signUp(loginBy: .manual, email: email, password: password, socialId: nil, firstName: firstName, lastName: lastName, mobile: mobile, referral_code: isReferalEnable == 0 ? "" : self.textFieldReferCode.text!, country_code: self.countryText.text)
            
     
    //               let storyBoard: UIStoryboard = UIStoryboard(name: "User", bundle: nil)
    //               let vc = storyBoard.instantiateViewController(withIdentifier: "CODETYPEVC") as! CODETYPEVC
    //
    //               vc.phone_no = self.countryText.text! + phoneNumber
    //               vc.email = email
    //
    //               self.navigationController?.pushViewController(vc, animated: true)
                    
     
        }
   
}
