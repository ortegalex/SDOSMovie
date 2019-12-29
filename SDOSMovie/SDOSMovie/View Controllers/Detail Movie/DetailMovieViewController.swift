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
    @IBOutlet weak var lbTitle: SDOSLabel!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lbActors: SDOSLabel!
    @IBOutlet weak var lbDirector: SDOSLabel!
    @IBOutlet weak var lbGenre: SDOSLabel!
    @IBOutlet weak var lbPlot: SDOSLabel!
    @IBOutlet weak var lbDuration: UILabel!
    @IBOutlet weak var openButton: UIButton!
    
    var imdbID: String!
    
    private var movie: MovieDetail? {
        didSet {
            self.lbTitle.text = movie?.title
            self.lbYear.text = movie?.year
            self.lbActors.text = movie?.actors
            self.lbDirector.text = movie?.director
            self.lbGenre.text = movie?.genre
            self.lbPlot.text = movie?.plot
            self.lbDuration.text = movie?.runtime
            self.imgPoster.setImage(movie?.poster ?? "", placeholder: UIImage(named: "film-poster-placeholder"))
            
            self.openButton.addTarget(self, action: #selector(openMovieOnIMDB) , for: .touchUpInside)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(expandImage))
            self.imgPoster.isUserInteractionEnabled = true
            self.imgPoster.addGestureRecognizer(tap)
            
            self.view.allSubViewsOf(type: SDOSLabel.self).forEach { $0.delegate = self }
            
        }
    }

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
                    strongSelf.movie = result
                case .failure(let error):
                    strongSelf.showAlertDialog(error, title: "Error", didClose: nil)
                    
                }
            }
        }
    }
    
    
    @objc func openMovieOnIMDB() {
        if !Functions.open(Constants.imdbUrl+imdbID) {
            self.showAlertDialog("No se puede abrir la película", title: "Aviso", didClose: nil)
        }
    }
    
    @objc func expandImage() {
        guard let movie = self.movie else { return }
        let vc = PosterMovieViewController(with: movie)
        let nc = UINavigationController(rootViewController: vc)
        self.present(nc, animated: true, completion: nil)
    }
    
    @objc func shareMovie() {
        let items = [URL(string: Constants.imdbUrl+imdbID)!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
}

// MARK: - SDOSLabel Delegate
extension DetailMovieViewController: SDOSLabelDelegate {
    func didTap(_ text: String) {
        showToast(message: "Texto copiado al portapapeles")
    }
}
