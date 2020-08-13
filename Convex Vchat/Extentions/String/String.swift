//
//  String.swift
//  Convex Vchat
//
//  Created by 1234 on 6/10/20.
//  Copyright © 2020 n0. All rights reserved.

import Foundation

extension String {
 
    static var Empty : String {
        return ""
    }
    
    static func removeNil(_ value : String?) -> String{
        return value ?? String.Empty
    }
    
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    // Localization
    
    func localize()->String{
        
        return NSLocalizedString(self, bundle: currentBundle, comment: "")
        
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
}
