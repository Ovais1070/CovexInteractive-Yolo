//
//  EditProfileVC.swift
//  ConvexVchat
//
//  Created by Ovais Naveed on 8/10/20.
//  Copyright © 2020 n0. All rights reserved.
//

import UIKit
import SDWebImage


class EditProfileVC: UIViewController {
    
    @IBOutlet weak var vUProfileImg: UIView!
    @IBOutlet weak var vUcorner: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profilePic: UIImageView!
    
    
    var editProfileVM = EditProfileVM()
    var getprofileVM = GetProfile()
    var imagePicker: UIImagePickerController!
    
    var firstName: String = ""
    var lastName: String = ""
    var country: String = ""
    var phone: String = ""
    var company: String = ""
    var email: String = ""
    var address: String = ""
    var website: String = ""
    var imageUrlString: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(EditProfileVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(EditProfileVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        navigationController?.navigationBar.tintColor = .white
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Edit Profile"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.368627451, green: 0, blue: 0.7764705882, alpha: 1)
        vUProfileImg.layer.borderWidth = 2
        vUProfileImg.layer.borderColor = #colorLiteral(red: 0.368627451, green: 0, blue: 0.7764705882, alpha: 1)
        vUProfileImg.makeCircular()
        vUcorner.makeCircular()
        profilePic.makeCircular()
        
        hideKeyboardWhenTappedAround()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        CellRegistration()
        
        let rightBtn = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveBtnAction))
        self.navigationItem.rightBarButtonItem = rightBtn
        self.getProfile()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    func CellRegistration(){
        tableView.register(UINib(nibName: "TypeACell", bundle: nil), forCellReuseIdentifier: "TypeACell")
        tableView.register(UINib(nibName: "TypeBCell", bundle: nil), forCellReuseIdentifier: "TypeBCell")
        tableView.register(UINib(nibName: "TypeCCell", bundle: nil), forCellReuseIdentifier: "TypeCCell")
        tableView.register(UINib(nibName: "EPSectionCell", bundle: nil), forCellReuseIdentifier: "EPSectionCell")
        
    }
    
    
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            tableView.setBottomInset(to: keyboardHeight)
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        tableView.setBottomInset(to: 0.0)
    }
    
    @objc func saveBtnAction() {
       print("firstName", firstName)
       print("lastName", lastName)
       print("Phone", phone)
       print("company", company)
       print("email", email)
       print("address", address)
       print("website", website)
        
        
        editProfileVM.PostProfile(uploadFile: profilePic.image!, firstName: firstName, lastName: lastName, country: "Pakistan", phone: User.main.mobile!, email: email, address: address, website: "www.convex.com")
        
        editProfileVM.updateProfileCompletionHandler { (status, message) in
            if status {
                self.view.makeToast(message)
            } else {
                self.view.makeToast(message)
            }
        }
        
        
    }
    
    
    func getProfile(){
        
        getprofileVM.GetProfile(phone: User.main.mobile!)
        
        getprofileVM.getProfileCompletionHandler { (status, message, responseData) in
            if status == true {
                self.view.makeToast(message)
               
                    print("Response Response Response", responseData)
                    self.firstName = responseData["first_name"] as! String
                    self.lastName = responseData["last_name"] as! String
                    self.email = responseData["email"] as? String ?? ""
                    self.address = responseData["address"] as? String ?? ""
                    self.imageUrlString = responseData["profile_pic"] as! String
                    self.profilePic.sd_setImage(with: URL(string: self.imageUrlString ), placeholderImage: UIImage(named: "add_a_photo.png"))
                    self.tableView.reloadData()
                
            } else {
                self.view.makeToast(message)
            }
        }
    }
    
    
    
    
    
    
    
    @IBAction func uploadImage(_ sender: Any) {
        
      // 1
      let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
      // 2
      let Camera = UIAlertAction(title: "Camera", style: .default, handler: { (action) -> Void in
        self.cameraLibrary()
      
      })
      let PhotoLibrary = UIAlertAction(title: "Photo Library", style: .default, handler: { (action) -> Void in
         
        self.photoLibrary()
      })
      // 3
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
      // 4
      optionMenu.addAction(Camera)
      optionMenu.addAction(PhotoLibrary)
      optionMenu.addAction(cancelAction)
      // 5
      self.present(optionMenu, animated: true, completion: nil)
    }
    
    
    func photoLibrary(){
           imagePicker = UIImagePickerController()
           imagePicker.allowsEditing = true
           imagePicker.sourceType = .photoLibrary
           imagePicker.delegate = self
         
           self.present(imagePicker, animated: true, completion: nil)
       }
       
       
       
       func cameraLibrary(){
           imagePicker = UIImagePickerController()
           imagePicker.allowsEditing = true
           imagePicker.sourceType = .camera
           imagePicker.delegate = self
          
           self.present(imagePicker, animated: true, completion: nil)
       }
    
    
    
    override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
        
            let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            print("picture selected345345")
            let imagePicked = pickedImage
            profilePic.image = imagePicked
//            let jpegCompressionQuality: CGFloat = 0.9
//            self.base64String1 = (imagePicked!.jpegData(compressionQuality: jpegCompressionQuality)?.base64EncodedString())!
//            print("base64String" , base64String1)
           
         
        
       
        self.dismiss(animated: true, completion: nil)
        print("picture selected")
    }
    
    
}







extension UITableView {
    
    func setBottomInset(to value: CGFloat) {
        let edgeInset = UIEdgeInsets(top: 0, left: 0, bottom: value, right: 0)
        
        self.contentInset = edgeInset
        self.scrollIndicatorInsets = edgeInset
    }
}

extension EditProfileVC: UITextFieldDelegate {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EditProfileVC.dismissKeyboard))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.tag == 0 {
            firstName = textField.text ?? ""
        } else if textField.tag == 1 {
            lastName = textField.text ?? ""
        } else if textField.tag == 2 {
            phone = textField.text ?? ""
        }else if textField.tag == 3 {
            company = textField.text ?? ""
        }else if textField.tag == 4 {
            email = textField.text ?? ""
        }else if textField.tag == 5 {
            address = textField.text ?? ""
        }else if textField.tag == 6 {
            website = textField.text!
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

    textField.resignFirstResponder();
    return true;
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
         if textField.tag == 0 {
             firstName = ""
         } else if textField.tag == 1 {
             lastName = ""
         } else if textField.tag == 2 {
             phone = ""
         }else if textField.tag == 3 {
             company = ""
         }else if textField.tag == 4 {
             email = ""
         }else if textField.tag == 5 {
             address = ""
         }else if textField.tag == 6{
             website = ""
         }
    }
    
}

extension EditProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let value = 0
        
        switch section {
        case 0:
            let value = 2
            return value
        case 1:
            let value = 2
            return value
        case 2:
            let value = 4
            return value
        default:
            print("")
        }
        return value
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TypeACell") as! TypeACell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "TypeBCell") as! TypeBCell
        let cell3 = tableView.dequeueReusableCell(withIdentifier: "TypeCCell") as! TypeCCell
        
        cell.selectionStyle = .none
        cell2.selectionStyle = .none
        cell3.selectionStyle = .none
        
        let sectionNumber = indexPath.section
        switch sectionNumber {
        case 0:
            if indexPath.row == 0{
                cell.nameText.placeholder = "First Name"
                cell.nameText.delegate = self
                cell.nameText.text = firstName
                cell.nameText.tag = 0
                
                
            } else if indexPath.row == 1 {
                cell.nameText.placeholder = "Last Name"
                cell.nameText.delegate = self
                cell.nameText.text = lastName
                cell.nameText.tag = 1
                
                return cell
            }
        case 1:
            if indexPath.row == 0{
                
                cell2.countryText.text = "Pakistan"
            
                
                return cell2
            } else {
                
                cell3.labelText.text = "Pk +92"
                cell3.labelText.textColor = #colorLiteral(red: 0.368627451, green: 0, blue: 0.7764705882, alpha: 1)
                cell3.inputText.placeholder = "Phone"
                cell3.inputText.delegate = self
                UserDefaults.standard.value(forKey: "mobileNO")
                //cell3.inputText.text = UserDefaults.standard.value(forKey: "mobileNO") as? String
                cell3.inputText.tag = 2
                
                return cell3
            }
            
        case 2:
            if indexPath.row == 0{
                cell3.labelText.text = "Company"
                cell3.inputText.placeholder = "Company"
                cell3.inputText.delegate = self
                cell3.inputText.tag = 3
                
                return cell3
            } else if indexPath.row == 1{
                cell3.labelText.text = "Email"
                cell3.inputText.placeholder = "Email"
                cell3.inputText.delegate = self
                cell3.inputText.text = email
                cell3.inputText.tag = 4
                
                return cell3
            }else if indexPath.row == 2{
                cell3.labelText.text = "Address"
                cell3.inputText.placeholder = "Address"
                cell3.inputText.delegate = self
                cell3.inputText.text = address
                cell3.inputText.tag = 5
                
                return cell3
            } else {
                cell3.labelText.text = "Website"
                cell3.inputText.placeholder = "Website"
                cell3.inputText.delegate = self
                cell3.inputText.tag = 6
                return cell3
            }
        default:
            print("")
        }
        
        return cell
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableCell(withIdentifier: "EPSectionCell") as? EPSectionCell
        
        if section == 0 {
            headerView?.title.text = "Name"
            return headerView
            
        }else if section == 1 {
            headerView?.title.text = "Phone"
            return headerView
        }else {
            headerView?.title.text = ""
            return headerView
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return 30
        }
        return 50
    }
    
}



