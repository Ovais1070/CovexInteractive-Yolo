//  Convex Vchat
//
//  Created by 1234 on 6/10/20.
//  Copyright © 2020 n0. All rights reserved.
import UIKit

enum Color : Int {
    
    case primary = 1
    case secondary = 2
    case lightBlue = 3
    case brightBlue = 4
    
    
    static func valueFor(id : Int)->UIColor?{
        
        switch id {
        case self.primary.rawValue:
            return .primary
            
        case self.secondary.rawValue:
            return .secondary
            
        case self.lightBlue.rawValue:
            return .lightBlue
            
        case self.brightBlue.rawValue:
            return .brightBlue
            
        default:
            return nil
        }
    }
}

extension UIColor {
    
    // Primary Color
    static var primary : UIColor {
        return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) //UIColor(red: 149/255, green: 117/255, blue: 205/255, alpha: 1)
    }
    
    // Secondary Color
    static var secondary : UIColor {
        return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) //UIColor(red: 238/255, green: 98/255, blue: 145/255, alpha: 1)
    }
    
    // Secondary Color
    static var rating : UIColor {
        return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) //UIColor(red: 238/255, green: 98/255, blue: 145/255, alpha: 1)
    }
    
    // Secondary Color
    static var lightBlue : UIColor {
        return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) //UIColor(red: 38/255, green: 118/255, blue: 188/255, alpha: 1)
    }
    
    //Gradient Start Color
    static var startGradient : UIColor {
        return UIColor(red: 83/255, green: 173/255, blue: 46/255, alpha: 1)
    }
    
    //Gradient End Color
    static var endGradient : UIColor {
        return UIColor(red: 158/255, green: 178/255, blue: 45/255, alpha: 1)
    }
    
    // Blue Color
    static var brightBlue : UIColor {
        return UIColor(red: 40/255, green: 25/255, blue: 255/255, alpha: 1)
    }
    
    func UInt()->UInt32{
        
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            
            var colorAsUInt : UInt32 = 0
            
            colorAsUInt += UInt32(red * 255.0) << 16 +
                UInt32(green * 255.0) << 8 +
                UInt32(blue * 255.0)
            return colorAsUInt
            
            // colorAsUInt == 0xCC6699 // true
        }
        return 0xCC6699
    }
}
