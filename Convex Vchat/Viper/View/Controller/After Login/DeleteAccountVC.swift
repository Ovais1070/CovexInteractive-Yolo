//
//  DeleteAccountVC.swift
//  ConvexVchat
//
//  Created by Ovais Naveed on 8/10/20.
//  Copyright © 2020 n0. All rights reserved.
//

import UIKit

class DeleteAccountVC: UIViewController {

    
    
    @IBOutlet weak var countryCode: UITextField!
    
    @IBOutlet weak var inputNum: UITextField!
    @IBOutlet weak var deleteAccountBtn: UIButton!
    @IBOutlet weak var changeNumBtn: UIButton!
    fileprivate let pickerView = ToolbarPickerView()
    
    fileprivate let titles = ["PK +92", "US +1", "AU +61", "NZ +64"]
    
    
    
    override func viewWillAppear(_ animated: Bool) {
         navigationController?.navigationBar.tintColor = .white
         self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.368627451, green: 0, blue: 0.7764705882, alpha: 1)
        self.navigationItem.title = "Delete Account"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        deleteAccountBtn.layer.cornerRadius = 5
        changeNumBtn.layer.cornerRadius = 5
        
        hideKeyboardWhenTappedAround()
        
        var imageView = UIImageView()
        var image = UIImage(named: "arrow_drop_down.png")
        imageView.image = image;
        countryCode.rightView = imageView
        countryCode.rightViewMode = UITextField.ViewMode.always
        
        
        
        
        self.countryCode.inputView = self.pickerView
        self.countryCode.inputAccessoryView = self.pickerView.toolbar

        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.toolbarDelegate = self

        self.pickerView.reloadAllComponents()
    }
    


    
    
    
   
    
    
    
    @IBAction func closeBtn(_ sender: Any) {
        print("Clear Number Field ")
        inputNum.text = nil
    }
    
    
    @IBAction func deleteAccountBtn(_ sender: Any) {
        
        print("Delete my account")
    }
    
    
    
    @IBAction func changeNumBtn(_ sender: Any) {
        print("change my Number")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ChangeNumberVC") as! ChangeNumberVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension DeleteAccountVC: UIPickerViewDataSource, UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.titles.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.titles[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.countryCode.text = self.titles[row]
    }
}

extension DeleteAccountVC: ToolbarPickerViewDelegate {

    func didTapDone() {
        let row = self.pickerView.selectedRow(inComponent: 0)
        self.pickerView.selectRow(row, inComponent: 0, animated: false)
        self.countryCode.text = self.titles[row]
        self.countryCode.resignFirstResponder()
    }

    func didTapCancel() {
        self.countryCode.text = nil
        self.countryCode.resignFirstResponder()
    }
}



extension DeleteAccountVC: UITextFieldDelegate {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DeleteAccountVC.dismissKeyboard))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
