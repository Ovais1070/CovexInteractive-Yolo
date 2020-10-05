//
//  ProfileVC.swift
//  ConvexVchat
//
//  Created by Ovais Naveed on 8/10/20.
//  Copyright © 2020 n0. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileVC: UIViewController {

    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var vUlayer1: UIView!
    @IBOutlet weak var vUlayer2: UIView!
    @IBOutlet weak var editProfileBtn: UIButton!
    var getprofileVM = GetProfile()
    var logoutVM = LogoutVM()
    var imageUrlString: String = ""
    
   
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = .white
        getProfile()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        
        
        tableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "ProfileCell")
        tableView.register(UINib(nibName: "sectionCell", bundle: nil), forCellReuseIdentifier: "SectionCell")
        tableView.delegate = self
        tableView.dataSource = self
       
        vUlayer1.makeCircular()
        vUlayer2.makeCircular()
        profileImg.makeCircular()
        tableView.tableFooterView = UIView()
        
        
                 
    }

    
    func getProfile(){
        
        getprofileVM.GetProfile(phone: User.main.mobile!)
        
        getprofileVM.getProfileCompletionHandler { (status, message, responseData) in
            if status == true {
                self.view.makeToast(message)
                
                    self.imageUrlString = responseData["profile_pic"] as! String
                    self.profileImg.sd_setImage(with: URL(string: self.imageUrlString ), placeholderImage: UIImage(named: "add_a_photo.png"))
                    self.tableView.reloadData()
                
            } else {
                self.view.makeToast(message)
            }
        }
    }
    
    
    
    func logOut(){
        logoutVM.Logout(mobileNumber: "923316519503")
        
        logoutVM.logoutCompletionHandler { (status, message) in
            if status == true {
                self.view.makeToast(message)
                if let appDomain = Bundle.main.bundleIdentifier {
                    UserDefaults.standard.removePersistentDomain(forName: appDomain)
                }
                
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "LaunchViewController") as! LaunchVC
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
                
            } else {
                self.view.makeToast(message)
            }
        }
        
        
    }
    
    
    
    @IBAction func editProfileBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        navigationController?.pushViewController(vc, animated: true)
    }
    

}







extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var value = 0
        
        switch section {
        case 0:
            let value = 2
            return value
        case 1:
            let value = 3
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as! ProfileCell
         cell.selectionStyle = .none
        let sectionNumber = indexPath.section
        switch sectionNumber {
        case 0:
            if indexPath.row == 0{
                
                cell.imgVu.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.title.text = "YoloApp Web/Desktop"
                cell.img.image = UIImage(named: "computer")
            } else {
                
                cell.imgVu.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0, blue: 0.4431372549, alpha: 1)
                cell.title.text = "Tell a Friend"
                cell.img.image = UIImage(named: "favorite")
            }
        case 1:
            if indexPath.row == 0{
                
                cell.imgVu.backgroundColor = #colorLiteral(red: 0.368627451, green: 0, blue: 0.7764705882, alpha: 1)
                cell.title.text = "Notifications"
                cell.img.image = UIImage(named: "notifications")
            } else if indexPath.row == 1{
                
                cell.imgVu.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.4470588235, blue: 0.1411764706, alpha: 1)
                cell.title.text = "Contacts"
                cell.img.image = UIImage(named: "supervisor")
            } else {
                cell.imgVu.backgroundColor = #colorLiteral(red: 0.007843137255, green: 0.5960784314, blue: 0.9960784314, alpha: 1)
                cell.title.text = "Calling settings"
                cell.img.image = UIImage(named: "ring")
                
            }
            
        case 2:
            if indexPath.row == 0{
                
                cell.imgVu.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
                cell.title.text = "Change my number"
                cell.img.image = UIImage(named: "sim")
            } else if indexPath.row == 1{
                
                cell.imgVu.backgroundColor = #colorLiteral(red: 1, green: 0.3058823529, blue: 0.2666666667, alpha: 1)
                cell.title.text = "Delete Account"
                cell.img.image = UIImage(named: "delete")
            }else if indexPath.row == 2{
                
                cell.imgVu.backgroundColor = #colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1803921569, alpha: 1)
                cell.title.text = "Logout"
                cell.img.image = UIImage(named: "exit")
            } else {
                cell.imgVu.backgroundColor = #colorLiteral(red: 0.007843137255, green: 0.5960784314, blue: 0.9960784314, alpha: 1)
                cell.title.text = "Feedback and help"
                cell.img.image = UIImage(named: "help")
                
            }
        default:
            print("")
        }
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let sectionNumber = indexPath.section
              switch sectionNumber {
              case 0:
                  if indexPath.row == 0{
                      
                      
                  } else {
                      
                     
                  }
              case 1:
                  if indexPath.row == 0{
                      
                      
                  } else if indexPath.row == 1{
                      
                     
                  } else {
                      
                      
                  }
                  
              case 2:
                  if indexPath.row == 0{
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "ChangeNumberVC") as! ChangeNumberVC
                    navigationController?.pushViewController(vc, animated: true)

                    
                  } else if indexPath.row == 1{
                      let storyboard = UIStoryboard(name: "Main", bundle: nil)
                      let vc = storyboard.instantiateViewController(withIdentifier: "DeleteAccountVC") as! DeleteAccountVC
                      navigationController?.pushViewController(vc, animated: true)
                     
                  }else if indexPath.row == 2{
                      logOut()
                      
                  } else {
                      let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                           let vc = storyboard.instantiateViewController(withIdentifier: "FAQsVC") as! FAQsVC
                                           navigationController?.pushViewController(vc, animated: true)
                      
                  }
              default:
                  print("")
              }
    }
    
    
    
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableCell(withIdentifier: "SectionCell") as? sectionCell
        
        if section == 0 {
             headerView?.title.text = ""
             return headerView
       
        }else if section == 1 {
            headerView?.title.text = "Preferences"
            return headerView
        }else {
            headerView?.title.text = "Account and Support"
            return headerView
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       if section == 0 {
           return 0
       }
     return 50
    }
    
}










extension UIView {
    func makeCircular() {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
        self.clipsToBounds = true
    }
    
    func makeCircular2() {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 1.6
        self.clipsToBounds = true
    }
    
    func makeCircular3() {
        self.layer.cornerRadius = self.frame.size.height / 1.6
        self.clipsToBounds = true
    }
}
