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
    
    
    
    fileprivate let pickerView = ToolbarPickerView()
    fileprivate let titles = ["PK +92", "US +1", "AU +61", "NZ +64"]
    
   
    @IBOutlet weak var nextBtn: UIButton!
    
    
    
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
        
        
        self.oldNumCode.inputView = self.pickerView
        self.oldNumCode.inputAccessoryView = self.pickerView.toolbar

        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.toolbarDelegate = self

        self.pickerView.reloadAllComponents()
        
        
    }
    


    @IBAction func clearOldNum(_ sender: Any) {
        inputOldNum.text = nil
    }


    @IBAction func clearNewNum(_ sender: Any) {
         inputNewNum.text = nil
    }
    
    
    
    @IBAction func nextBtn(_ sender: Any) {
        
        print("Next Clicked")
    }
    
}


extension ChangeNumberVC: UIPickerViewDataSource, UIPickerViewDelegate {

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
        
            self.newNumCode.text = self.titles[row]
     
    }

}

extension ChangeNumberVC: ToolbarPickerViewDelegate {

    func didTapDone() {
       
            let row = self.pickerView.selectedRow(inComponent: 0)
            self.pickerView.selectRow(row, inComponent: 0, animated: false)
        self.oldNumCode.text = self.titles[row]
        self.oldNumCode.resignFirstResponder()
        
    }

    func didTapCancel() {
        self.oldNumCode.text = nil
        self.oldNumCode.resignFirstResponder()
    }
}



extension ChangeNumberVC: UITextFieldDelegate {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChangeNumberVC.dismissKeyboard))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
