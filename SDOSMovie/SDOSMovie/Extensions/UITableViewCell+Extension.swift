//
//  UITableViewCell+Extension.swift
//  SDOSMovie
//
//  Created by Alex Ortega on 28/12/2019.
//  Copyright © 2019 Alex Ortega. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
