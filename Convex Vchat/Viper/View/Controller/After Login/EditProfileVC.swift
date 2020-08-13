//
//  EditProfileVC.swift
//  ConvexVchat
//
//  Created by Ovais Naveed on 8/10/20.
//  Copyright © 2020 n0. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {
    
    @IBOutlet weak var vUProfileImg: UIView!
    @IBOutlet weak var vUcorner: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
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
        
        hideKeyboardWhenTappedAround()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        CellRegistration()
        
        let rightBtn = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveBtnAction))
        self.navigationItem.rightBarButtonItem = rightBtn
        
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
        print("Button Pressed")
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
                
            } else if indexPath.row == 1 {
                cell.nameText.placeholder = "Last Name"
                
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
                return cell3
            }
            
        case 2:
            if indexPath.row == 0{
                cell3.labelText.text = "Company"
                cell3.inputText.placeholder = "Company"
                return cell3
            } else if indexPath.row == 1{
                cell3.labelText.text = "Email"
                cell3.inputText.placeholder = "Email"
                return cell3
            }else if indexPath.row == 2{
                cell3.labelText.text = "Address"
                cell3.inputText.placeholder = "Address"
                return cell3
            } else {
                cell3.labelText.text = "Website"
                cell3.inputText.placeholder = "Website"
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


