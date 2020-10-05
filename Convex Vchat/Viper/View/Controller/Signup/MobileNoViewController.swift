//
//  SignUpUserTableViewController.swift
//  User
//
//  Created by CSS on 07/05/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import UIKit
import Foundation
import Toast_Swift
import FSPagerView
class MobileNoViewController: UITableViewController  {
    
   
    
    
    
    //MARK:- IBOutlets
    
    @IBOutlet var countryText: HoshiTextField!
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet var nextBtn: UIButton!

      @IBOutlet var phoneNumber: HoshiTextField!
    //MARK:- Local Variable
 
    private var userInfo : UserData?
    var checkUserVM = CheckUserVM()
    var sendRegisterOTPVM = SendRegisterOTPVM()
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
extension MobileNoViewController {
    
    //NextButtonTapped
        @IBAction func nextBtnTapped(sender : UIButton){
            
      
            guard let lastName = phoneNumber.text, lastName.trimmed().count > 0 else {
                self.showToast(string: ErrorMessage.list.enterMobileNumber)
                return
            }
            
            let code = countryText.text?.replacingOccurrences(of: "+", with: "")
            let mobileNo = "\(code!)\(phoneNumber.text!)"
            
            self.loader.isHidden = false
            
            checkUser()

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


extension MobileNoViewController : PostViewProtocol , DPKWebOperationDelegate {
   
        func callBackFailResponse(dictResponse: [String : Any]) {
                  
           if dictResponse["data"] != nil
                             {

                               let data_dic : NSDictionary = dictResponse["data"] as! [String : Any] as NSDictionary



                              if  data_dic["exist"] as! Bool == false
                              {

                               let message : String =  (dictResponse["message"] as? String)!
                              // Alert.show(vc: self, titleStr: "Message", messageStr:message)
                               self.view.makeToast("OOPS! it seems like the number is already registered.", duration: 3.0, position: .center)
                               }

                               }
        }
    
    func getProfile(api: Base, data: Profile?) {
       
       
        print("profile?.data.dob", data?.data.exist ?? "")
        User.main.mobile = data?.data.mobile
        if data?.data.exist == true
        {
            self.phoneNumber.shake()
            vibrate(with: .weak)
            self.loader.isHidden = true

            self.showToast(string: ErrorMessage.list.userAlreadyRegistered)

            DispatchQueue.main.async {
                self.phoneNumber.becomeFirstResponder()
            }
        }
        else {
               sendOtp()
        }
        
        
        
    }
    
    
 func success(api: Base, message: String?) {
     
    
    
     if api == .phoneNumVerify {
        
        
        
//self.presenter?.get(api: .locationService, parameters: nil)
     }
 }
    
    func onError(api: Base, message: String, statusCode code: Int) {
        
        print("eroor phone")

        
        if api == .phoneNumVerify {
            
            
            print("eroor phone")
            
            self.phoneNumber.shake()
            vibrate(with: .weak)
            DispatchQueue.main.async {
                self.phoneNumber.becomeFirstResponder()
            }
        }
    }
     

      
    func sendOtp(){
        
        //let parameters : [String : String] = ["mobile" :User.main.mobile ?? ""]
        let code = countryText.text?.replacingOccurrences(of: "+", with: "")
        let mobileNo = "\(code!)\(phoneNumber.text!)"
        
        sendRegisterOTPVM.sendOtpData(mobileNumber: mobileNo)
        sendRegisterOTPVM.sendOTPCompletionHandler { (status, message) in
            if status == true {
                self.loader.isHidden = true
                print("CheckUsermessage", message)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "VerificationCodeViewController") as! VerificationCodeViewController
                Common.isFrom = "signUp"
                User.main.mobile = mobileNo
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
                
                self.view.makeToast(message)
            } else {
                self.loader.isHidden = true
                
                self.view.makeToast(message)
            }
        }
    }

    
    
    func checkUser(){
        
        //let parameters : [String : String] = ["mobile" :User.main.mobile ?? ""]
        let code = countryText.text?.replacingOccurrences(of: "+", with: "")
        let mobileNo = "\(code!)\(phoneNumber.text!)"
        
        checkUserVM.CheckUserData(mobileNumber: mobileNo)
        checkUserVM.checkUserCompletionHandler { (status, message) in
            if status == true {
                self.loader.isHidden = true
                print("CheckUsermessage", message)
                
                self.view.makeToast(message)
            } else {
                self.loader.isHidden = true
                self.sendOtp()
                self.view.makeToast(message)
            }
        }
        
        
    }

 
//    let code = countryText.text?.replacingOccurrences(of: "+", with: "")
//    let mobileNo = "\(code!)\(phoneNumber.text!)"
//    presenter?.get(api: .sendOtpSignup, parameters: [Keys.list.mobile : mobileNo])

     
//
    
    func convertDicIntoJson(jsonObject:Dictionary<String, Any>)
    {
        
        do {
               let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
               // here "jsonData" is the dictionary encoded in JSON data

               let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
               // here "decoded" is of type `Any`, decoded from JSON data

               // you can now cast it with the right type
               if let dictFromJSON = decoded as? [String:String] {
                   print(dictFromJSON)
               }
           } catch {
               print(error.localizedDescription)
           }
    }
    
    
    func callBackSuccessResponseData(dictResponse: Data) {
        
        print("callBackSuccessResponseData", dictResponse)
        
        UserSingleton.share.ProfileData =  PresenterProcessor.shared.profile(data: dictResponse)
        
       let userData = PresenterProcessor.shared.profile(data: dictResponse)
        
        
        User.main.mobile = UserSingleton.share.ProfileData?.data.mobile ?? ""
        if UserSingleton.share.ProfileData?.data.exist  == true
        {
            self.phoneNumber.shake()
            vibrate(with: .weak)
            self.loader.isHidden = true

            self.showToast(string: ErrorMessage.list.userAlreadyRegistered)

            DispatchQueue.main.async {
                self.phoneNumber.becomeFirstResponder()
        }
        }
        else
        {
            
            self.loader.isHidden = true
//            sendOtp()
            self.present(id: Storyboard.Ids.VerificationCodeViewController, animation: true)

        }
        
        print("callBackSuccessResponseData",UserSingleton.share.ProfileData?.data.last_name ?? "")

        
        
    }
       func callBackSuccessResponse(dictResponse: [String:Any]) {
               print("callBackSuccessResponse", dictResponse)
//
//
//
//                if dictResponse["data"] != nil
//                 {
//
////                    if let data = dictResponse["data"]  as? [String : Any]
////                    {
//                        if let status = dictResponse["status"] as? Bool
//                        {
//                            if status == true
//                            {
//                                self.loader.isHidden = true
//
//
//                            }
//                       // }
//                    }
//
//                 }
        
   
//
}
  
}

// MARK:- UITextFieldDelegate

extension MobileNoViewController : UITextFieldDelegate {
    
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



