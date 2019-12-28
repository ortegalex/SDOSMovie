//
//  UIImageView+Extension.swift
//  SDOSMovie
//
//  Created by Alex Ortega on 28/12/2019.
//  Copyright © 2019 Alex Ortega. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {

    func setImage(_ url: String, placeholder: UIImage? = nil) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: URL(string: url), placeholder: placeholder)
    }
}

