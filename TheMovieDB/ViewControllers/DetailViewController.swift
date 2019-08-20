//
//  DetailViewController.swift
//  TheMovieDB
//
//  Created by Eduardo Sarmanho on 20/08/19.
//  Copyright © 2019 Ronald Maciel. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    var movieTitle = ""
    var genre: [String] = []
    var rating = 0.0
    var descript = ""
    var image = ""
    var genreAux = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        genreAux = genre.compactMap{ $0 }.joined(separator: ", ")
        
        movieTitleLabel.text = movieTitle
        genreLabel.text = genreAux
        ratingLabel.text = "\(rating)"
        descriptionTextView.text = descript
        Network.getImageAPI(imagePath: self.image, completion: { image in
            self.imageView.image = image
        })    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        movieTitleLabel.text = movieTitle
//        genreLabel.text = "\(genre)"
//        ratingLabel.text = "\(rating)"
//        descriptionTextView.text = descript
//        Network.getImageAPI(imagePath: self.image, completion: { image in
//            self.imageView.image = image
//        })
//    }

}
