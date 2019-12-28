//
//  MovieTableViewCell.swift
//  SDOSMovie
//
//  Created by Alex Ortega on 28/12/2019.
//  Copyright © 2019 Alex Ortega. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else {return}
            self.lbTitle.text = movie.title
            self.lbYear.text = movie.year
            self.imgPoster.setImage(movie.poster, placeholder: UIImage(named: "film-poster-placeholder"))
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        containerView.addCorner()
    }
    
}
