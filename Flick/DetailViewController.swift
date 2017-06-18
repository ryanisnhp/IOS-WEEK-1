//
//  DetailViewController.swift
//  Flick
//
//  Created by admin on 6/15/17.
//  Copyright © 2017 nhp. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: *** Local variables
    
    // MARK: *** Data Models
    
    // MARK: *** UI Elements
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var filmTitle: UILabel!
    @IBOutlet weak var fullOverview: UILabel!
    
    // MARK: *** UI Events
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let contentWidth = scrollView.bounds.width
        let contentHeight = scrollView.bounds.height
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
