//
//  SignInTableViewController.swift
//  ConvexVchat
//
//  Created by 1234 on 6/19/20.
//  Copyright © 2020 n0. All rights reserved.
//

 

import UIKit
import Foundation
import Toast_Swift


class SignInTableViewController: UITableViewController  {
    
   
    
    
    
    //MARK:- IBOutlets
    
    @IBOutlet var countryText: HoshiTextField!
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var phoneNumber: HoshiTextField!

    //MARK:- Local Variable
 
    private var userInfo : UserData?
 
    private var countryCode : String?

    lazy var loader  : UIView = {
        return createActivityIndicator(self.view)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationcontroller()
        self.setDesign()
        
        print("User.main.firstName",User.main.username ?? "")
 
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
    
     
    // check User Api Call

     
}

 
 

// Mark:- Local Methods
extension SignInTableViewController {
    
    //NextButtonTapped
        @IBAction func nextBtnTapped(sender : UIButton){
            
      
            guard let lastName = phoneNumber.text, lastName.trimmed().count > 0 else {
                self.showToast(string: ErrorMessage.list.enterMobileNumber)
                return
            }
            
            let code = countryText.text?.replacingOccurrences(of: "+", with: "")
            let mobileNo = "\(code!)\(phoneNumber.text!)"
            
            self.loader.isHidden = false
            
            
            signIn()
            
            
          //  presenter?.get(api: .phoneNumVerify, parameters: [Keys.list.mobile : mobileNo])
            
         
            
         }
        
        
    
    // Designs
    
    private func setDesign() {
        
         Common.setFont(to: countryText)
         Common.setFont(to: phoneNumber)
 
       
    }
    
    func GotoVerV()
    
    {
        
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
//          addGustureforNextBtn()
       // self.view.dismissKeyBoardonTap()
        self.countryText.delegate = self
        self.phoneNumber.delegate = self
 
       if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
                print(countryCode)
                let country = Common.getCountries()
                for eachCountry in country {
                    if countryCode == eachCountry.code {
                        print(eachCountry.dial_code)
                        countryText.text = eachCountry.dial_code
                        let myImage = UIImage(named: "CountryPicker.bundle/\(eachCountry.code).png")
                         countryImageView.image = myImage
                    }
                }
            }
    }
   
    
    }
         
     
 

// MARK:- ApiCallRespose


extension SignInTableViewController :    DPKWebOperationDelegate {
    func callBackSuccessResponseData(dictResponse: Data) {
        
        
        
    }
    
   
        
   
    func signIn(){
               
         
               let code = countryText.text?.replacingOccurrences(of: "+", with: "")
               let mobileNo = "\(code!)\(phoneNumber.text!)"
        
                User.main.mobile = mobileNo
               let parameters : [String : String] = ["mobile" :mobileNo]

               
               print("parameters for Login", parameters)
               self.loader.isHidden = false
           DPKWebOperation.operation_delegate = self
                //Call WebService
               
        DPKWebOperation.WebServiceCalling(vc: self, dictPram: parameters, methodName: Constants.signIn)
          
    }

  
       func callBackSuccessResponse(dictResponse: [String:Any]) {
               print("callBackSuccessResponseSignin", dictResponse)
 
        
        if dictResponse["data"] != nil
                 {
                    
//                    if let data = dictResponse["data"]  as? [String : Any]
//                    {
                        if let status = dictResponse["status"] as? Bool
                        {
                            if status == true
                            {
                                self.loader.isHidden = true

                                Common.isFrom = "signin"

                                
                                self.present(id: Storyboard.Ids.VerificationCodeViewController, animation: true)
                                
                                
                                
                            }
                       // }
                    }
 
                 }
         
}
    
    func callBackFailResponse(dictResponse: [String : Any]) {
                      
                 
        
               if dictResponse["data"] != nil
            
               {

                if  dictResponse["status"] as! Bool == false
                
                {
                             
                    
                    self.loader.isHidden = true
                    
                    
                self.present(id: Storyboard.Ids.VerificationCodeViewController, animation: true)

    //                let message : String =  (dictResponse["message"] as? String)!
    //                self.phoneNumber.shake()
    //                vibrate(with: .weak)
    //                self.loader.isHidden = true
    //                self.view.makeToast(message, duration: 3.0, position: .center)
                                                                  
                
                }
                                    
           
                }

        

              }
        
         
  
}

// MARK:- UITextFieldDelegate

extension SignInTableViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == countryText {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CountryListController") as! CountryListController
            self.present(vc, animated: true, completion: nil)
            vc.searchCountryCode = { code in
                self.countryCode = code
                let country = Common.getCountries()
                for eachCountry in country {
                    if code == eachCountry.code {
                        self.countryText.text = eachCountry.dial_code
                        let myImage = UIImage(named: "CountryPicker.bundle/\(eachCountry.code).png")
                        self.countryImageView.image = myImage
                    }
                }
            }
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        (textField as? HoshiTextField)?.borderActiveColor = .primary
         
    }
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.phoneNumber && range.location == 0
        {
            if string.hasPrefix("0"){
                return false
            }
        }
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 10
        //return true
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        (textField as? HoshiTextField)?.borderActiveColor = .primary
         
        if textField == phoneNumber {
                   if phoneNumber.text != "" {
                       let user = User()
                    let num = "\(String(describing: countryCode))\(phoneNumber.text!)"
                    //   user.mobile = phoneNumber.text
                     //  user.country_code = countryText.text
                     //  presenter?.post(api: .phoneNumVerify, data: user.toData())
                    
                   
                    
                    
                    //presenter?.get(api: .phoneNumVerify, parameters: [Keys.list.mobile : num])
                   }
               }
        
        
             if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
                let country = Common.getCountries()
                for eachCountry in country {
                    if countryCode == eachCountry.code {
                        countryText.text = eachCountry.dial_code
                    }
//                }
//            }
        
                }
                
        }
    }
}



