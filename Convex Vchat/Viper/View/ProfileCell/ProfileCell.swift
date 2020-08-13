//
//  ProfileCell.swift
//  Yolo
//
//  Created by Ovais Naveed on 7/8/20.
//  Copyright © 2020 Ovais Naveed. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    
    
    @IBOutlet weak var imgVu: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgVu.makeCircular()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    
}
