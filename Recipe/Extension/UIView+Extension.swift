//
//  UIView+Extension.swift
//  Recipe
//
//  Created by Roshan sah on 22/11/20.
//

import UIKit

extension UIView {

    func addShadow() {
        self.layer.cornerRadius = 20.0
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 12.0
        self.layer.shadowOpacity = 0.7
        
    }
}
