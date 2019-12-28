//
//  UIView+Extension.swift
//  SDOSMovie
//
//  Created by Alex Ortega on 28/12/2019.
//  Copyright © 2019 Alex Ortega. All rights reserved.
//

import UIKit

extension  UIView {
    
    func addCorner( _ radius: CGFloat = 6) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
        
}
