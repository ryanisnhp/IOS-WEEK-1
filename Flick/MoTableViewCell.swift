//
//  MoTableViewCell.swift
//  Flick
//
//  Created by admin on 6/18/17.
//  Copyright © 2017 nhp. All rights reserved.
//

import UIKit

class MoTableViewCell: UITableViewCell {

    // MARK: *** Local variables
    
    // MARK: *** Data Models
    
    // MARK: *** UI Elements
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    // MARK: *** UI Events
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10.0
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        view.layer.shadowOpacity = 0.2
    }
    
}
