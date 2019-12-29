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
    
    func showToast(message : String, font: UIFont = UIFont.systemFont(ofSize: 16)) {
        let toastLabel = UILabel(frame: CGRect(x: 30, y: self.view.frame.size.height-100, width: self.view.frame.size.width-60, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}
