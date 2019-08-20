//
//  asdCollectionViewCell.swift
//  TheMovieDB
//
//  Created by Eduardo Sarmanho on 20/08/19.
//  Copyright © 2019 Ronald Maciel. All rights reserved.
//

import UIKit

class NowPlayingFullCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    var movieDescription: String = ""
    var genre: [String] = []
}
