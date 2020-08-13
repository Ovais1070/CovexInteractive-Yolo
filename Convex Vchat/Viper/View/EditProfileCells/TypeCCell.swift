//
//  TypeCCell.swift
//  Yolo
//
//  Created by Ovais Naveed on 7/10/20.
//  Copyright © 2020 Ovais Naveed. All rights reserved.
//

import UIKit

class TypeCCell: UITableViewCell {
   
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var inputText: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
