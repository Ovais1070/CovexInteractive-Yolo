//
//  FAQCell.swift
//  Yolo
//
//  Created by Ovais Naveed on 7/14/20.
//  Copyright © 2020 Ovais Naveed. All rights reserved.
//

import UIKit

class FAQCell: UITableViewCell {

    
    @IBOutlet weak var questions: UILabel!
    @IBOutlet weak var bgVu: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        bgVu.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
