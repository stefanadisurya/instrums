//
//  Colors.swift
//  Instrums
//
//  Created by Stefan Adisurya on 28/04/21.
//

import UIKit
import AsyncDisplayKit

class Colors {
    static func setBackground(view: ASDisplayNode) {
        let colorTop = UIColor(red: 0.0/255.0, green: 145.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 1.0/255.0, green: 86.0/255.0, blue: 151.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        
//        view.layer.insertSublayer(gradientLayer, at: 0)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
