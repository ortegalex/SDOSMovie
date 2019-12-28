//
//  MoviesEmptyView.swift
//  SDOSMovie
//
//  Created by Alex Ortega on 28/12/2019.
//  Copyright © 2019 Alex Ortega. All rights reserved.
//

import UIKit

class MoviesEmptyView: UIView {

    lazy var imageView: UIImageView = {
        let image = UIImage(named: "film")
        let imgView = UIImageView(image: image)
        imgView.alpha = 0.4
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    lazy var textInfo: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 13.0/255.0, green: 123.0/255.0, blue: 123.0/255.0 , alpha: 0.6)
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textInfo.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        addSubview(textInfo)
        
        imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        textInfo.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        textInfo.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        if #available(iOS 11.0, *) {
            textInfo.topAnchor.constraint(equalToSystemSpacingBelow: imageView.topAnchor, multiplier: 15).isActive = true
        } else {
            textInfo.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        }
        
    }
    
    func setMessage(message: String) {
        textInfo.text = message
    }

}
