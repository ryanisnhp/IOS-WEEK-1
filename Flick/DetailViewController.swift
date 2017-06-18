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
    var selectedMovie: AnyObject?
    let endPointLowResPoster = "https://image.tmdb.org/t/p/w45"
    let endPointHighResPoster = "https://image.tmdb.org/t/p/w342"
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
        let contentHeight = scrollView.bounds.height + 150
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
        loadData()
    }
    func loadData(){
        filmTitle.text = selectedMovie?["original_title"] as? String
        let rat = selectedMovie!["vote_average"] as! Float
        rating.text = "Rating: " + String(rat)
        fullOverview.text = selectedMovie?["overview"] as? String
        let fullLinkImage = endPointHighResPoster.appending((selectedMovie?["poster_path"] as? String)!)
        imagePoster.setImageWith(URL(string: fullLinkImage)!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
