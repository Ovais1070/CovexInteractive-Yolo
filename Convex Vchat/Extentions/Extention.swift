//
//  Extention.swift
//  ConvexVchat
//
//  Created by Ovais Naveed on 9/4/20.
//  Copyright © 2020 n0. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
