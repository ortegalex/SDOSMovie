//
//  DetailMovieViewController.swift
//  SDOSMovie
//
//  Created by Alex Ortega on 28/12/2019.
//  Copyright © 2019 Alex Ortega. All rights reserved.
//

import UIKit

class DetailMovieViewController: UIViewController {

    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lbActors: UILabel!
    @IBOutlet weak var lbDirector: UILabel!
    @IBOutlet weak var lbGenre: UILabel!
    @IBOutlet weak var lbPlot: UILabel!
    @IBOutlet weak var openButton: UIButton!
    
    var imdbID: String!
    var shareUrl = ""

    init(with imdbID: String) {
        self.imdbID = imdbID
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.imdbID = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareMovie))
        self.navigationItem.rightBarButtonItem = shareButton
        
        getMovieDetail(imdbID)
    }
    
    private func getMovieDetail(_ withId: String) {
        EZLoadingActivity.show("Loading", disableUI: true)
        containerView.alpha = 0
        MovieAPIService.getMovie(byId: withId) {[weak self] (result:ResultHandler<MovieDetail>) in
            guard let strongSelf = self else { return }
            EZLoadingActivity.hide()
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    strongSelf.containerView.alpha = 1
                }
                switch result {
                case .success(let result):
                    strongSelf.configureView(withMovie: result)
                    print(result)
                case .failure(let error):
                    strongSelf.showAlertDialog(error.localizedDescription, title: "Error", didClose: nil)
                    
                }
            }
        }
    }
    
    private func configureView(withMovie movie: MovieDetail) {
        self.lbTitle.text = movie.title
        self.lbYear.text = movie.year
        self.lbActors.text = movie.actors
        self.lbDirector.text = movie.director
        self.lbGenre.text = movie.genre
        self.lbPlot.text = movie.plot
        self.imgPoster.setImage(movie.poster, placeholder: UIImage(named: "film-poster-placeholder"))
        
        self.shareUrl = Constants.imdbUrl+imdbID
        
        self.openButton.addTarget(self, action: #selector(openMovieOnIMDB) , for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleExpandImage))
        self.imgPoster.isUserInteractionEnabled = true
        self.imgPoster.addGestureRecognizer(tap)
        
    }
    
    
    @objc func openMovieOnIMDB() {
        if !Helpers.open(self.shareUrl) {
            self.showAlertDialog("No se puede abrir la película", title: "Aviso", didClose: nil)
        }
    }
    
    @objc func toggleExpandImage() {
        print("Togle image!!")
    }
    
    @objc func shareMovie() {
        let items = [URL(string: self.shareUrl)!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    

}
