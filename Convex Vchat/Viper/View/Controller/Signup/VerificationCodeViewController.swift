//
//  VerificationCodeViewController.swift
//  Convex Vchat
//
//  Created by 1234 on 6/12/20.
//  Copyright © 2020 n0. All rights reserved.
//

import UIKit

class VerificationCodeViewController: UITableViewController {

    //MARK:- IBOutlets

    @IBOutlet var codeText: HoshiTextField!
    @IBOutlet var mobNoLabel: UILabel!
    
    //MARK:- localVariables
    
    var apiFlag = ""
    
    lazy var loader  : UIView = {
           return createActivityIndicator(self.view)
       }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationcontroller()
        self.setDesign()
        self.sendOtp()
        
        
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
extension VerificationCodeViewController {
    
    // Designs
    
    @IBAction func nextBtnTapped(sender : UIButton){
          
    
          guard let lastName = codeText.text, lastName.trimmed().count > 0 else {
              self.showToast(string: ErrorMessage.list.enterVerCode)
              self.codeText.shake()
              vibrate(with: .weak)
              return
          }
        
        self.loader.isHidden = false
        self.getoTp()
          
//          let code = countryText.text?.replacingOccurrences(of: "+", with: "")
//          let mobileNo = "\(code!)\(phoneNumber.text!)"
//          presenter?.get(api: .phoneNumVerify, parameters: [Keys.list.mobile : mobileNo])
//
       
          
       }
    private func setDesign() {
        
        Common.setFont(to: codeText ?? "")
        
        Common.setFont(to: mobNoLabel ?? "")
        
        mobNoLabel.text = "Enter the code sent to " + (User.main.mobile ?? "") 
 
       
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
        self.codeText.delegate = self
 
       
    }
    
}


// MARK:- UITextFieldDelegate


extension VerificationCodeViewController : DPKWebOperationDelegate {
    func callBackSuccessResponseData(dictResponse: Data) {
        
        
        
        print("callBackSuccessResponseData", dictResponse)
             
             UserSingleton.share.ProfileData =  PresenterProcessor.shared.profile(data: dictResponse)
             
            let userData = PresenterProcessor.shared.profile(data: dictResponse)
             
             
             User.main.mobile = UserSingleton.share.ProfileData?.data.mobile ?? ""
             if UserSingleton.share.ProfileData?.status  == false
             {
                self.codeText.shake()
                 vibrate(with: .weak)
                 self.loader.isHidden = true

                 self.showToast(string: ErrorMessage.list.userAlreadyRegistered)

                 DispatchQueue.main.async {
                     self.codeText.becomeFirstResponder()
             }
             }
             else
             {
                self.loader.isHidden = true
                if apiFlag == "getotp"
                {
                  
                    print("Common.isFrom", Common.isFrom)

                    
                    
                if Common.isFrom == "signin"
                {
                     
                    
                    Common.storeUserData(from: PresenterProcessor.shared.profile(data: dictResponse))
                    storeInUserDefaults()
                    
                    self.dismiss(animated: false, completion: nil)

                      
                    self.push(id: Storyboard.Ids.HomeViewController, animation: true)
                    
                    
                    
                    
                }
                else
                {
                   if apiFlag == "getotp"
                   {
                   self.present(id:Storyboard.Ids.DOBViewController, animation: true)
                   self.view.endEditingForce()
                   }
                }
                    
                }
                
              }
        
        
    }
    
    func callBackSuccessResponse(dictResponse: [String : Any]) {
         
    }
    
    func callBackFailResponse(dictResponse: [String : Any]) {
         if let status = dictResponse["status"] as? Bool
                {
   if status == true
   {
       self.present(id:Storyboard.Ids.DOBViewController, animation: true)
   }
   else
   {
       if let message = dictResponse["message"] as? String
       {
       showToast(string: message)
       vibrate(with: .weak)
       self.codeText.shake()
        self.loader.isHidden = true

       }
   }
        }
    }
    func sendOtp(){
                     
                     //let parameters : [String : String] = ["mobile" :User.main.mobile ?? ""]
                      let parameters : [String : String] = ["mobile" :User.main.mobile ?? ""]

                     
                     print("parameters for checkUser", parameters)
                 DPKWebOperation.operation_delegate = self
                      //Call WebService
        
        
        print("Common.isFrom", Common.isFrom)
        if Common.isFrom == "signin"
        {
            self.loader.isHidden = true

            //DPKWebOperation.WebServiceCalling(vc: self, dictPram: parameters, methodName: Constants.signInOtp)

        }
        else{
            self.loader.isHidden = false

              DPKWebOperation.WebServiceCalling(vc: self, dictPram: parameters, methodName: Constants.signUpOtp)
        }
                 }


func getoTp(){
       
    apiFlag = "getotp"
    let parameters : [String : String] = ["mobile" :User.main.mobile ?? "", "code" : codeText.text!]
       
       
       print("parameters for Map", parameters)
       
   DPKWebOperation.operation_delegate = self
        //Call WebService
       
DPKWebOperation.WebServiceCalling(vc: self, dictPram: parameters, methodName: "get-otp")
   }
}
// MARK:- UITextFieldDelegate

extension VerificationCodeViewController : UITextFieldDelegate {
    
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
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 4
        //return true
        
    }
}


