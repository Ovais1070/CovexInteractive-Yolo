//
//  Common.swift
//  User
//
//  Created by imac on 1/1/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import UIKit
import MessageUI
 
class Common {
    
    static let main = UIStoryboard(name: "Main", bundle: Bundle.main)

    class func isValid(email : String)->Bool{
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@","[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        return emailTest.evaluate(with: email)
    }
    
    static var isFrom = ""

    class func getBackButton()->UIBarButtonItem{
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        return backItem// This will show in the next view controller being pushed
    }
    
    //    class func GMSAutoComplete(fromView : GMSAutocompleteViewControllerDelegate?)->GMSAutocompleteViewController{
    //
    //    let gmsAutoCompleteFilter = GMSAutocompleteFilter()
    //    gmsAutoCompleteFilter.country =  GMSCountryCode
    //    gmsAutoCompleteFilter.type = .city
    //    let gmsAutoComplete = GMSAutocompleteViewController()
    //    gmsAutoComplete.delegate = fromView
    //    gmsAutoComplete.autocompleteFilter = gmsAutoCompleteFilter
    //    return gmsAutoComplete
    //    }
    
    
    class func getCurrentCode()->String?{
        
        return (Locale.current as NSLocale).object(forKey:  NSLocale.Key.countryCode) as? String
    }
    
    
    //MARK:- Get Countries from JSON
    
    class func getCountries()->[Country]{

        var source = [Country]()

        if let data = NSData(contentsOfFile: Bundle.main.path(forResource: "countryCodes", ofType: "json") ?? "") as Data? {
            do{
                source = try JSONDecoder().decode([Country].self, from: data)

            } catch let err {
                print(err.localizedDescription)
            }
        }
        return source
    }
    
    
    
    class func getRefreshControl(intableView tableView : UITableView, tintcolorId  : Int = Color.primary.rawValue, attributedText text : NSAttributedString? = nil)->UIRefreshControl{
        
        let rc = UIRefreshControl()
//        rc.tintColorId = tintcolorId
        rc.attributedTitle = text
        tableView.addSubview(rc)
        return rc
    }
    
    class func storeUserData(from profile : Profile?){

     //   User.main.id = profile?.id
        User.main.first_name = profile?.data.first_name
        User.main.last_name = profile?.data.last_name
        
        
       // print("profile?.data.first_name",profile?.data.first_name)
        

//        if let language = profile?.language {
//            UserDefaults.standard.set(language.rawValue, forKey: Keys.list.language)
//            setLocalization(language: language)
//        }
//        if let stripeKey = profile?.stripe_publishable_key {
//            User.main.stripeKey = stripeKey
//            STPPaymentConfiguration.shared().publishableKey = User.main.stripeKey ?? stripePublishableKey
//        }
    }
    
      //MARK:- Set AfterLogin Controller
        class func setAfterLoginController()->UIViewController {
             
            let vc = main.instantiateViewController(withIdentifier: Storyboard.Ids.HomeViewController)
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.isNavigationBarHidden = true
            return navigationController
         }
     
    
    // MARK:- Make Call
//    class func call(to number : String?) {
//
//        if let providerNumber = number, let url = URL(string: "tel://\(providerNumber)"), UIApplication.shared.canOpenURL(url) {
//            UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
//        } else {
//            UIApplication.shared.keyWindow?.make(toast: Constants.string.cannotMakeCallAtThisMoment.localize())
//        }
//
//    }
    
//    class func open(url urlString: String) {
//        if let  url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
//            UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
//        }
//    }
    
//    // MARK:- Send Email
//    class func sendEmail(to mailId : [String], from view : UIViewController & MFMailComposeViewControllerDelegate) {
//
//        if MFMailComposeViewController.canSendMail() {
//            let mail = MFMailComposeViewController()
//            mail.mailComposeDelegate = view
//            mail.setToRecipients(mailId)
//            mail.setSubject(helpSubject.localize())
//            view.present(mail, animated: true)
//        } else {
//           // UIScreen.main.focusedView?.make(toast: Constants.string.couldnotOpenEmailAttheMoment.localize())
//             UIApplication.shared.keyWindow?.make(toast: Constants.string.couldnotOpenEmailAttheMoment.localize())
//        }
//    }
    
    // MARK:- Send Message
    
    class func sendMessage(to numbers : [String], text : String, from view : UIViewController & MFMessageComposeViewControllerDelegate) {
        
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = text
            controller.recipients = numbers
            controller.messageComposeDelegate = view
            view.present(controller, animated: true, completion: nil)
        }
    }
    
//    // MARK:- Bussiness Image Url
//    class func getImageUrl (for urlString : String?)->String {
//
//        return baseUrl+"/storage/"+String.removeNil(urlString)
//    }
//
    
    // MARK:- Set Font
    
    class func setFont(to field :Any, isTitle : Bool = false, size : CGFloat = 0) {

        let customSize = size > 0 ? size : (isTitle ? 15  : 15)
        let font = UIFont(name: isTitle ? FontCustom.Bold.rawValue : FontCustom.Medium.rawValue, size: customSize)
        switch (field.self) {
        case is UITextField:
            (field as? UITextField)?.font = font
             
        case is UILabel:
            (field as? UILabel)?.font = font//UIFont(name: isTitle ? FontCustom.avenier_Heavy.rawValue : FontCustom.avenier_Medium.rawValue, size: customSize)
             
        case is UIButton:
            (field as? UIButton)?.titleLabel?.font = font

            
        case is UITextView:
            (field as? UITextView)?.font = font//UIFont(name: isTitle ? FontCustom.avenier_Heavy.rawValue : FontCustom.avenier_Medium.rawValue, size: customSize)
            //(field as? UITextView)?.textAlignment = (selectedLanguage == .arabic && (field as! UITextView).textAlignment == .left) ? .right : .left
        default:
            break
        }
    }

//    //  Get Chat Id
//
//    class func getChatId(with requestId : Int?) -> String {
//
//        guard  let requestId = requestId else {
//            return ProcessInfo().globallyUniqueString }
//
//        return "\(requestId)" //userId <= providerId ? "u\(userId)_p\(providerId)" : "p\(providerId)_u\(userId)"
//
//    }
//
//
//}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
}
