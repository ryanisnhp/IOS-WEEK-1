//
//  MovieCell.swift
//  Flick
//
//  Created by admin on 6/13/17.
//  Copyright © 2017 nhp. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    // MARK: *** Local variables
    
    // MARK: *** Data Models
    
    // MARK: *** UI Elements
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    
    // MARK: *** UI Events
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10.0
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        view.layer.shadowOpacity = 0.2
    }


}
