//
//  CircleImageView.swift
//  CheckersApp
//
//  Created by Thiago Nitschke Simões on 02/04/19.
//  Copyright © 2019 Thiago Nitschke Simões. All rights reserved.
//

import UIKit


@IBDesignable public class CustomImageView: UIImageView {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var radius: CGFloat = 50.0 {
        didSet {
            frame.size.width = radius * 2
            frame.size.height = radius * 2
            layer.cornerRadius = radius
        }
        
    }
}
