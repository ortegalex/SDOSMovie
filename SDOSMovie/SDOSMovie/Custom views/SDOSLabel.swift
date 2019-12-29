//
//  SDOSLabel.swift
//  SDOSMovie
//
//  Created by Alex Ortega on 29/12/2019.
//  Copyright © 2019 Alex Ortega. All rights reserved.
//

import UIKit

protocol SDOSLabelDelegate: class {
    func didTap(_ text: String)
}

class SDOSLabel: UILabel {

    weak var delegate: SDOSLabelDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapActionHandler(_:))))
    }
    
    @objc private func tapActionHandler(_ sender: UITapGestureRecognizer) {
        UIPasteboard.general.string = text
        delegate?.didTap(text ?? "")
    }

}
