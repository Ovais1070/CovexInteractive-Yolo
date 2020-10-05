//
//  SignUpUserTableViewController.swift
//  Convex Vchat
//
//  Created by 1234 on 6/10/20.
//  Copyright © 2020 n0. All rights reserved.

import UIKit
 
class SignUpUserTableViewController: UITableViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet var firstNameText: HoshiTextField!
     @IBOutlet var lastNameText: HoshiTextField!
  
    //MARK:- Local Variable
    
//    private var userInfo : UserData?
     var isReferalEnable = 0
    
    private lazy var  loader = {
           return createActivityIndicator(UIApplication.shared.keyWindow ?? self.view)
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationcontroller()        
        self.setDesign()
    }
     @IBAction func iconAction(sender: AnyObject) {
            
            
 
        }
    
    @IBAction func iconAction2(sender: AnyObject) {
               
               
 
           }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        localize()
        self.navigationController?.isNavigationBarHidden = false
       // self.presenter?.get(api: .settings, parameters: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
     }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      }
    
    override func viewWillDisappear(_ animated: Bool) {
 //        super.viewWillDisappear(animated)
    }
    
}

// Mark:- Local Methods
extension SignUpUserTableViewController {
    
    // Designs
    
    private func setDesign() {
        
         Common.setFont(to: firstNameText)
         Common.setFont(to: lastNameText)
 
       
    }
    
    private func localize(){
        
       // self.firstNameText.placeholder = Constants.string.first.localize()
      //  self.lastNameText.placeholder = Constants.string.last.localize()
     }
    
    func setNavigationcontroller(){
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationBar.barTintColor = UIColor.white
        }
       // title = Constants.string.registerDetails.localize()
        // self.navigationController?.navigationBar.tintColor = UIColor.white
       // self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .plain, target: self, action: #selector(self.backButtonClick))
//        addGustureforNextBtn()
       // self.view.dismissKeyBoardonTap()
        self.firstNameText.delegate = self
        self.lastNameText.delegate = self
 
       
    }
    
//    private func addGustureforNextBtn(){
//
//        let nextBtnGusture = UITapGestureRecognizer(target: self, action: #selector(nextBtnTapped(sender:)))
//        self.nextView.addGestureRecognizer(nextBtnGusture)
//    }
    
     
    
    //NextButtonTapped
    @IBAction func nextBtnTapped(sender : UIButton){
        
        //sender.view?.addPressAnimation()
         self.view.endEditingForce()
 
        self.loader.isHidden = false

        guard let firstName = self.firstNameText.text, firstName.trimmed().count > 1 else {
            self.showToast(string: ErrorMessage.list.enterFirstName)
            self.firstNameText.shake()
            vibrate(with: .weak)
            return
        }
        guard let lastName = lastNameText.text, lastName.trimmed().count > 0 else {
             self.showToast(string: ErrorMessage.list.enterLastName)
            self.lastNameText.shake()
            vibrate(with: .weak)
            return
        }
        
        User.main.first_name = firstName
        User.main.last_name = lastName

        self.loader.isHidden = true
        self.present(id: Storyboard.Ids.MobileNoViewController, animation: true)
         
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

 
 


// MARK:- UITextFieldDelegate

extension SignUpUserTableViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
         
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        (textField as? HoshiTextField)?.borderActiveColor = .primary
         
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        (textField as? HoshiTextField)?.borderActiveColor = .primary
         
        
        
        
        if textField == lastNameText {
//            if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
//               // let country = Common.getCountries()
//                for eachCountry in country {
//                    if countryCode == eachCountry.code {
//                        countryText.text = eachCountry.dial_code
//                    }
//                }
//            }
        }
    }
}



