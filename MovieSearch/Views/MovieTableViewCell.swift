//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Will morris on 5/17/19.
//  Copyright © 2019 devmtn. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // Take in movie object and call updateviews
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    // Update text of labels on view
    func updateViews() {
        guard let movie = movie else { return }
        titleLabel.text = movie.title
        ratingLabel.text = "\(movie.rating)"
        overviewLabel.text = movie.overview
    }
}
