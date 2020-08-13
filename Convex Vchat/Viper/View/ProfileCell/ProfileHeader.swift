//
//  ProfileHeader.swift
//  Yolo
//
//  Created by Ovais Naveed on 7/9/20.
//  Copyright © 2020 Ovais Naveed. All rights reserved.
//

import UIKit

class ProfileHeader: UITableViewCell {

    @IBOutlet weak var vulayer1: UIView!
    @IBOutlet weak var vulayer2: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vulayer1.makeCircular()
        vulayer2.makeCircular()
        profileImg.makeCircular()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
