//
//  ContactsViewController.swift
//  ConvexVchat
//
//  Created by 1234 on 6/24/20.
//  Copyright © 2020 n0. All rights reserved.
//

import UIKit
import Contacts
import Alamofire
import CoreData
import SwiftyJSON
import Letters






class ContactsViewController: UITableViewController, UISearchBarDelegate  {
    
    
    
    
    
    
    
    var people: [NSManagedObject] = []
    var childVC: ContactCell? = nil
    var uniqueId  = ""
    var dataArray : NSArray = NSArray()
    var contactInfo = [UserContactInfo]()
    //        var userContactInfo = [[String : String]]()
    //    var name: String = ""
    //    var cellNumber: String = ""
    
    
    var contacts = [FetchedContact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let vc = HomeViewController()
        //        vc.delegate = self
        
        
        let udid = UIDevice.current.identifierForVendor?.uuidString
        uniqueId = udid ?? ""
        print("UDID", udid ?? "")
        
        // self.tableView.register(ContactCell.self, forCellReuseIdentifier: "ContactCell")
        tableView.register(UINib(nibName: "ContactCell", bundle: nil), forCellReuseIdentifier: "ContactCell")
        
        
        
        
        
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Contacts")
        
        //3
        do {
            people = try managedContext.fetch(fetchRequest)
            
            print("peoplepeoplepeople", people.count)
            
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        if self.people.count == 0
        {
            fetchContacts()
            
            
            
        }
        
        
        
    }
    
    
    
    
    
    func MakeAudioCall(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RingingAudioCallVC") as! RingingAudioCallVC
        navigationController?.pushViewController(vc,
                                                 animated: true)
        
        
    }
    
    
    func MakeVideoCall(index : Int){
        
        let person = people[index]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CallViewController") as! CallViewController
        //        vc.clientName = person.
        //        vc.clientNumber = cellNumber
        navigationController?.pushViewController(vc,
                                                 animated: true)
        
    }
    
    
    func refresh() {
        print("Successfully Refreshed Called")
    }
    
    
    private func fetchContacts() {
        print("Attempting to fetch contacts")
        
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("failed to request access", error)
                return
            }
            
            if granted {
                print("access granted")
                
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey,CNContactThumbnailImageDataKey,CNContactImageDataAvailableKey,CNContactImageDataKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                do {
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                        print(contact.givenName)
                        
                        var imgData = Data()
                        
                        
                        self.contacts.append(FetchedContact(firstName: contact.givenName, image: imgData, lastName: contact.familyName, telephone: contact.phoneNumbers.first?.value.stringValue  ?? ""))
                    })
                    
                    self.sendcontacts()
                    self.getContacts()
                    
                } catch let error {
                    print("Failed to enumerate contact", error)
                }
            } else {
                print("access denied")
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return people.count
        //        return contactInfo.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCell
        cell.selectionStyle = .none
        //   let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell
        
        //        let checkCount = people.count
        //        print("checkCountcheckCountcheckCount", checkCount)
        
        
        
        let person = people[indexPath.row]
        let clientName = person.value(forKeyPath: "name") as? String
        // Configure the cell...
        cell.contactName?.text = person.value(forKeyPath: "name") as? String
        cell.contactNumber?.text = person.value(forKeyPath: "mobile") as? String
        cell.parentVC = self
        (cell as! ContactCell).configure(name: person.value(forKeyPath: "name") as? String ?? "")
        //        let contact = contactInfo[indexPath.row]
        //
        //        cell.contactName?.text = contact.name
        //        cell.contactNumber?.text = String(contact.number)
        if person.value(forKey: "exist") as? Int == 0 {
            
            cell.makeAudioCall.isHidden = true
            cell.makeVideoCall.isHidden = true
            cell.inviteBtn.isHidden = false
        }
        //
        //
        //
        //        cell.makeVideoCall.tag = indexPath.row
        
        //        self.cellNumber = person.value(forKeyPath: "mobile") as! String
        
        
        
        //cell.backgroundView?.image = UIImage(data: contacts[indexPath.row].image)
        //        if contacts[indexPath.row].image != nil
        //        {
        //      //cell.contactImage.image = UIImage(data: contacts[indexPath.row].image)
        //         cell.contactImage.image = UIImage(named: "DummyPic")
        //            print("Image is there", contacts[indexPath.row].image) // its giving 0 byte
        //        } else {
        //            cell.contactImage.image = UIImage(named: "DummyPic")
        //
        //        }
        //    save(name: contacts[indexPath.row].firstName, number: contacts[indexPath.row].telephone)
        
        
        //         print("cell.detailTextLabel?.text" , person.value(forKeyPath: "mobile") as? String)
        
        
        
        
        return cell
    }
}

extension ContactsViewController :   DPKWebOperationDelegate {
    func callBackSuccessResponseData(dictResponse: Data) {
        
        
        
        
    }
    
    func callBackSuccessResponse(dictResponse: [String : Any]) {
        
    }
    
    func callBackFailResponse(dictResponse: [String : Any]) {
        
    }
    func sendcontacts(){
        
        
        
        var arrDict = Array<Dictionary<String,Any>>()  //Your array
        
        for usercontacts in contacts {
            
            arrDict.append(["name":usercontacts.firstName,"number":usercontacts.telephone])
            
            
        }
        
        var contactJson = convertToJsonParam(data: arrDict)
        
        
        let payload = ["mobile" : User.main.mobile! , "contacts": contactJson , "deviceId" : uniqueId] as [String : Any]
        //        let payload = ["mobile" : User.main.mobile! , "page": 1 , "deviceId" : uniqueId] as [String : Any]
        
        
        print("parameters for sendcontacts", payload)
        
        //               DPKWebOperation.operation_delegate = self
        //                   //Call WebService
        //
        //           DPKWebOperation.WebServiceCalling(vc: self, dictPram: payload, methodName: Constants.importUserContacts)
        
        AuthService.instance.ImportContacts(MethodName: Constants.importUserContacts, params: payload, successCompletionHandler: { (response) in
            
            print("RESPONSE" , response)
            
            
            
            let responseCode = response["code"] as! Int
            
            switch responseCode{
            case 200:
                print("Response is 200")
            case 400 :
                print("Error")
            default:
                print("")
                break
                
                
                
            }
            
            
        }) { (response: String) in
            self.view.makeToast(response)
            print("NON - Success reponse",response)
        }
        
        
        
    }
    
    func getContacts(){
        var arrDict = Array<Dictionary<String,Any>>()  //Your array
        
        for usercontacts in contacts {
            arrDict.append(["name":usercontacts.firstName,"number":usercontacts.telephone])
        }
        
        var contactJson = convertToJsonParam(data: arrDict)
        
        let payload = ["mobile" : User.main.mobile! , "page": 1 , "deviceId" : uniqueId] as [String : Any]
        
        AuthService.instance.ImportContacts(MethodName: Constants.fetchUserContacts, params: payload, successCompletionHandler: { (response) in
            
            print("RESPONSE Get Contacts:" , response)
            let responseCode = response["code"] as! Int
            
            switch responseCode{
            case 200:
                
                if let dataArray = response["data"]{
                    self.dataArray = response["data"] as! NSArray
                    
                    self.contactInfo.removeAll()
                    print("dataArray" , self.dataArray)
                    let jsonData = JSON(response)
                    
                    for item in jsonData["data"].array ?? [] {
                        let newItem = UserContactInfo(data: item)
                        self.contactInfo.append(newItem)
                    }
                    
                    for i in 0..<self.contactInfo.count {
                        self.save(name: self.contactInfo[i].name , number: String(self.contactInfo[i].number), exist: self.contactInfo[i].exists)
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                    
                }
            case 400 :
                print("Error")
            default:
                print("")
                break
            }
        
        
        }) { (response: String) in
            self.view.makeToast(response)
            print("NON - Success reponse",response)
        }
        
        
        
    }
    
    func convertToJsonParam(data: [[String : Any]] ) -> String {
        
        var json = ""
        
        do
        {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
            let jsonString = String(data: jsonData, encoding: String.Encoding.ascii)!
            print ("jsonStringjsonString",jsonString)
            
            json =   jsonString
            
            let parameters: [String: Any] = ["contacts":  json]
            print ("jsonStringjsonStringparameters",parameters)
            return json
        }
            
        catch let error as NSError {
            print(error)
            return ""
        }
    }
}
