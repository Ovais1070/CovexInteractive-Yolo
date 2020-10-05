//
//  Button.swift
//  User
//
//  Created by imac on 12/22/17.
//  Copyright © 2017 Appoets. All rights reserved.
//

import UIKit

//MARK:- Designable class UIButton

 @IBDesignable
 class GradientButton: UIButton {
    
    @IBInspectable var cornerRadiusValue: CGFloat = 10.0 {
        didSet {
            setUpView()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    func setUpView() {
        self.layer.cornerRadius = self.cornerRadiusValue
        self.clipsToBounds = true
    }
     let gradientLayer = CAGradientLayer()
     
     @IBInspectable
     var topGradientColor: UIColor? {
         didSet {
             setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
         }
     }
     
     @IBInspectable
     var bottomGradientColor: UIColor? {
         didSet {
             setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
         }
     }
     
     private func setGradient(topGradientColor: UIColor?, bottomGradientColor: UIColor?) {
         if let topGradientColor = topGradientColor, let bottomGradientColor = bottomGradientColor {
            gradientLayer.frame = bounds
             gradientLayer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
             gradientLayer.borderColor = layer.borderColor
             gradientLayer.borderWidth = layer.borderWidth
             gradientLayer.cornerRadius = layer.cornerRadius
             layer.insertSublayer(gradientLayer, at: 0)
            gradientLayer.frame = bounds
         } else {
             gradientLayer.removeFromSuperlayer()
         }
     }
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
 }
}
