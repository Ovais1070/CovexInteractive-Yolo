//
//  VerificationCodeViewController.swift
//  Convex Vchat
//
//  Created by 1234 on 6/12/20.
//  Copyright © 2020 n0. All rights reserved.
//

import UIKit

class VerificationCodeViewController: UITableViewController {
    var window: UIWindow?
    //MARK:- IBOutlets
    
    @IBOutlet var codeText: HoshiTextField!
    @IBOutlet var mobNoLabel: UILabel!
    
    //MARK:- localVariables
    
    var apiFlag = ""
    var sendOTPVM = SendOTPVM()
    var getOTPVM = GetOTPVM()
    
    lazy var loader  : UIView = {
        return createActivityIndicator(self.view)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationcontroller()
        self.setDesign()
        if Common.isFrom != "signUp"{
            self.sendOtp()
        }
    }
    
    
    
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
        self.codeText.delegate = self
    }
    
    
    
    func sendOtp(){
        
        let mobileNumber = User.main.mobile
        
        sendOTPVM.sendOtpData(mobileNumber: mobileNumber!)
        sendOTPVM.sendOTPCompletionHandler { (status, message) in
            
            if status {
                self.loader.isHidden = true
                
                
                
                self.view.makeToast(message)
            } else {
                self.loader.isHidden = true
                self.view.makeToast(message)
            }
        }
    }
    
    func getoTp(){
        
        apiFlag = "getotp"
        let mobileNumber = User.main.mobile
        
        if codeText.text?.count != 0 {
            
            getOTPVM.getOtpData(mobileNumber: mobileNumber!, code: codeText.text!)
            
            getOTPVM.getOTPCompletionHandler {(response, status, message) in
                if status {
                    self.loader.isHidden = true
                    if self.apiFlag == "getotp"
                    { print("Common.isFrom", Common.isFrom)
                        if Common.isFrom == "signin"
                        {
                            print("response response response", response)
                            Common.storeUserData(from: PresenterProcessor.shared.profile(data: response as Data))
                            storeInUserDefaults()
                            
                           
                           let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            let  mainView = UIStoryboard(name:"Main", bundle: nil)
                                                       let viewcontroller : UIViewController = mainView.instantiateViewController(withIdentifier: "NavigationVC") as! NavigationVC
                            appDelegate.window!.rootViewController = viewcontroller
                            
//                            self.dismiss(animated: false) {
//                                self.push(id: Storyboard.Ids.NavigationVC, animation: true)
//                            }
                        } else if self.apiFlag == "getotp"
                        {
                            self.present(id:Storyboard.Ids.DOBViewController, animation: true)
                            self.view.endEditingForce()
                        }
                    }
                    self.view.makeToast(message)
                } else {
                    
                    self.loader.isHidden = true
                    self.view.makeToast(message)
                }
            }
            
            self.getOTPVM.errorCompletionHandler { (message) in
                     self.loader.isHidden = true
                self.view.makeToast(message, point: CGPoint(x: UIScreen.main.bounds.size.width  / 2, y: UIScreen.main.bounds.size.height  / 2), title: nil, image: nil, completion: nil)
                           }
        } else {
            print("code text is empty")
        }
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


