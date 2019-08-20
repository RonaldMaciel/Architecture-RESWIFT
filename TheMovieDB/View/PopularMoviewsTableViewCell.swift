//
//  PopularMoviewsTableViewCell.swift
//  TheMovieDB
//
//  Created by Eduardo Sarmanho on 16/08/19.
//  Copyright © 2019 Ronald Maciel. All rights reserved.
//

import Foundation
import UIKit

class PopularMovieTableViewCell: UITableViewCell {
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieRatingLabel: UILabel!
    var genre: [String] = []
}
