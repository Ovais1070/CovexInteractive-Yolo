//
//  FAQsVC.swift
//  ConvexVchat
//
//  Created by Ovais Naveed on 8/10/20.
//  Copyright © 2020 n0. All rights reserved.
//

import UIKit

class FAQsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    var data: [String] = ["I want to log in to my account","I forgot my password","My account is suspended","I can't create an account","My account logged out automatically","Other"]
    
    
    
    override func viewWillAppear(_ animated: Bool) {
         navigationController?.navigationBar.tintColor = .white
         
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationItem.title = "Feedback and help"
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.368627451, green: 0, blue: 0.7764705882, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        
        tableView.register(UINib(nibName: "FAQCell", bundle: nil), forCellReuseIdentifier: "FAQCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    

   

}

extension FAQsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQCell") as! FAQCell
        
        cell.questions.text = data[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}
