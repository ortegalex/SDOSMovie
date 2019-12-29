//
//  PosterMovieViewController.swift
//  SDOSMovie
//
//  Created by Alex Ortega on 28/12/2019.
//  Copyright © 2019 Alex Ortega. All rights reserved.
//

import UIKit

class PosterMovieViewController: UIViewController {

    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var btSavePoster: UIButton!
    
    var movie: MovieDetail!
    
    init(with movie: MovieDetail) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.movie = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = movie.title
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePoster))
        self.navigationItem.rightBarButtonItem = saveButton
        self.imgPoster.setImage(movie.poster, placeholder: UIImage(named: "film-poster-placeholder"))
    }
    
    @objc func savePoster(_ sender: Any) {
        if let image = self.imgPoster.image {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }

    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            self.showAlertDialog(error.localizedDescription, title: "Save error", didClose: nil)
        } else {
            self.showAlertDialog("Poster image has been saved to your photos", title: "Saved!", didClose: {
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    

}
