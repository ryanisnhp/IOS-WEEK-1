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
        //let smallImageUrl = endPointLowResPoster.appending((selectedMovie?["poster_path"] as? String)!)
        let largeImageUrl = endPointHighResPoster.appending((selectedMovie?["poster_path"] as? String)!)
        //imagePoster.setImageWith(URL(string: fullLinkImage)!)
        
        //let smallImageRequest = NSURLRequest(url: NSURL(string: smallImageUrl)! as URL)
        //let largeImageRequest = NSURLRequest(url: NSURL(string: largeImageUrl)! as URL)
        
        fadeImage(imageUrl: largeImageUrl)
        
    }
    func fadeImage(imageUrl : String){
        let imageRequest = NSURLRequest(url: NSURL(string: imageUrl)! as URL)
        self.imagePoster.setImageWith(
            imageRequest as URLRequest,
            placeholderImage: nil,
            success: { (imageRequest, imageResponse, image) -> Void in
                
                // imageResponse will be nil if the image is cached
                if imageResponse != nil {
                    print("Image was NOT cached, fade in image")
                    self.imagePoster.alpha = 0.0
                    self.imagePoster.image = image
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                        self.imagePoster.alpha = 1.0
                    })
                } else {
                    print("Image was cached so just update the image")
                    self.imagePoster.image = image
                }
        },
            failure: { (imageRequest, imageResponse, error) -> Void in
                // do something for the failure condition
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
