//
//  ChangeNumberVC.swift
//  ConvexVchat
//
//  Created by Ovais Naveed on 8/10/20.
//  Copyright © 2020 n0. All rights reserved.
//

import UIKit

class ChangeNumberVC: UIViewController {

    
    
    @IBOutlet weak var oldNumCode: UITextField!
    @IBOutlet weak var newNumCode: UITextField!
    @IBOutlet weak var inputOldNum: UITextField!
    @IBOutlet weak var inputNewNum: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    
    
    private var countryCode : String?
    var changeNumberVM = ChangeNumVM()
    
    override func viewWillAppear(_ animated: Bool) {
         navigationController?.navigationBar.tintColor = .white
         
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.368627451, green: 0, blue: 0.7764705882, alpha: 1)
        self.navigationItem.title = "Change my number"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let imageView = UIImageView()
        let image = UIImage(named: "arrow_drop_down.png")
        imageView.image = image;
        oldNumCode.rightView = imageView
        oldNumCode.rightViewMode = UITextField.ViewMode.always
        
        let SecondimageView = UIImageView()
        let img = UIImage(named: "arrow_drop_down.png")
        SecondimageView.image = img;
        newNumCode.rightView = SecondimageView
        newNumCode.rightViewMode = UITextField.ViewMode.always
        
        nextBtn.layer.cornerRadius = 5
        
        
        hideKeyboardWhenTappedAround()
         let code = User.main.mobile
//        oldNumCode.delegate = self
        oldNumCode.isUserInteractionEnabled = false
        inputOldNum.isUserInteractionEnabled = false
        oldNumCode.text = "+" + "\(String(code?.prefix(2) ?? ""))"
        inputOldNum.text = String(code?.suffix(10) ?? "")
        newNumCode.delegate = self
        
       
        
        print("numbernumbernumber", code)
        
    }
    


    @IBAction func clearOldNum(_ sender: Any) {
//        inputOldNum.text = nil
    }


    @IBAction func clearNewNum(_ sender: Any) {
         inputNewNum.text = nil
    }
    
    
    
    @IBAction func nextBtn(_ sender: Any) {
        
        
        print("Button pressed")
        if inputNewNum.text?.count != 0 {
        let wholeNew = String(describing: newNumCode.text!.dropFirst(1)) + (String(describing: inputNewNum.text!))
        let newNum = wholeNew
        
        let oldNumber = "\(String(describing: oldNumCode.text!.dropFirst(1)))\(String(describing: inputOldNum.text!))"
         print("newNumber", newNum)
        print("oldNumbers",oldNumber )
        changeNumberVM.PostNumber(newNumber: newNum, oldNumber: oldNumber)
        } else {
            print("Please enter number")
        }
        changeNumberVM.updateNumberCompletionHandler { (status, message) in
            if status {
                self.view.makeToast(message)
            } else {
                self.view.makeToast(message)
            }
        }
    }
    
}





// MARK:- UITextFieldDelegate

extension ChangeNumberVC : UITextFieldDelegate {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChangeNumberVC.dismissKeyboard))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == oldNumCode || textField == newNumCode {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CountryListController") as! CountryListController
            self.present(vc, animated: true, completion: nil)
            vc.searchCountryCode = { code in

                    self.countryCode = code


                let country = Common.getCountries()
                for eachCountry in country {
                    if code == eachCountry.code {
                        if textField == self.oldNumCode {
                                           self.oldNumCode.text = eachCountry.dial_code
                        } else if textField == self.newNumCode {
                            self.newNumCode.text = eachCountry.dial_code
                        }

                    }
                }
            }
            return false
        }
        
       
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       if textField == oldNumCode {
            print("textfeild pressed")
        }
         
    }
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.newNumCode && range.location == 0
        {
            if string.hasPrefix("0"){
                return false
            }
        } else if textField == self.oldNumCode && range.location == 0
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
         
        if textField == inputOldNum {
                   if inputOldNum.text != "" {
                       let user = User()
                    let num = "\(String(describing: countryCode))\(inputOldNum.text!)"
                    //   user.mobile = phoneNumber.text
                     //  user.country_code = countryText.text
                     //  presenter?.post(api: .phoneNumVerify, data: user.toData())
                    
                   
                    
                    
                    //presenter?.get(api: .phoneNumVerify, parameters: [Keys.list.mobile : num])
                   } else  if inputNewNum.text != "" {
                                         let user = User()
                                      let num = "\(String(describing: countryCode))\(inputNewNum.text!)"
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
                        if textField == self.oldNumCode {
                                           self.oldNumCode.text = eachCountry.dial_code
                        } else if textField == self.newNumCode {
                            self.newNumCode.text = eachCountry.dial_code
                        }
                        
                    }
//                }
//            }
        
                }
                
        }
    }
}
