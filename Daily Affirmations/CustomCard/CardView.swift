//
//  CardView.swift
//  Daily Affirmations
//
//  Created by Мирас on 7/30/20.
//  Copyright © 2020 Мирас. All rights reserved.
//

import UIKit

@IBDesignable class CardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 2
    
    @IBInspectable var shadowOffsetWidth: CGFloat = 0
    
    @IBInspectable var shadowOffsetHeight: CGFloat = 5
    
    @IBInspectable var shadowColor: UIColor = UIColor.white
    
    @IBInspectable var shadowOpacity: CGFloat = 0.5
    
    
    override func layoutSubviews() {
        
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
    }
}
