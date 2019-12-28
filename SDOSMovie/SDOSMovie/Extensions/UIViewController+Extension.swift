//
//  UIViewController+Extension.swift
//  SDOSMovie
//
//  Created by Alex Ortega on 28/12/2019.
//  Copyright © 2019 Alex Ortega. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertDialog(_ message: String, title: String? = nil, didClose: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            didClose?()
        }
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
