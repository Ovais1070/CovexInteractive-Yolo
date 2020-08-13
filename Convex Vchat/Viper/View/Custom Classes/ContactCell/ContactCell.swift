//
//  ContactCell.swift
//  ConvexVchat
//
//  Created by 1234 on 6/25/20.
//  Copyright © 2020 n0. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    
    //MArk IBOutlet
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var contactNumber: UILabel!
    @IBOutlet weak var makeVideoCall: UIButton!
    @IBOutlet weak var makeAudioCall: UIButton!
    
    @IBOutlet weak var inviteBtn: UIButton!
    
    
    var parentVC: ContactsViewController? = nil
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        inviteBtn.layer.cornerRadius = 5
        inviteBtn.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
    
    
    func configure(name: String) {
        contactName?.text = name
        contactImage?.setImage(string: name, color: UIColor.colorHash(name: name), circular: true)
    }
    
    
    @IBAction func makeVideoCall(_ sender: Any) {
        
        
        parentVC?.MakeVideoCall(index: (sender as AnyObject).tag)
    }
    
    @IBAction func makeAudioCall(_ sender: Any) {
        parentVC?.MakeAudioCall()
    }
    
    
    
    

    
}
