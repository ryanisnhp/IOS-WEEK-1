//
//  ViewController.swift
//  Flick
//
//  Created by admin on 6/13/17.
//  Copyright © 2017 nhp. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: *** Local variables
    let refreshControl = UIRefreshControl()
    var arrMovie = [AnyObject]()
    let endPointPoster = "https://image.tmdb.org/t/p/w342"
    // MARK: *** Data Models
    
    // MARK: *** UI Elements
    
    @IBOutlet weak var tableView: UITableView!
    // MARK: *** UI Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(ViewController.fetchData), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        fetchData()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    func fetchData(){
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = URLRequest(
            url: url!,
            cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: nil,
            delegateQueue: OperationQueue.main
        )
        // Display HUD right before the request is made
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let task: URLSessionDataTask =
            session.dataTask(with: request, completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! JSONSerialization.jsonObject(
                        with: data, options:[]) as? NSDictionary {
                        //print("response: \(responseDictionary)")
                        if let results = responseDictionary["results"] as? [AnyObject] {
                            self.arrMovie = results
                            self.tableView.reloadData()
                            self.refreshControl.endRefreshing()
                            // Hide HUD once the network request comes back (must be done on main UI thread)
                            MBProgressHUD.hide(for: self.view, animated: true)
                        }

                    }
                }
            })
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailVC" {
            //let dest = segue.destination as! DetailViewController
        }
    }
    
    // MARK: *** UITableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //return number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrMovie.count
    }
    //set data for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCellID") as! MovieCell
        
        let title = arrMovie[indexPath.row]["original_title"] as! String
        cell.name.text = title
        let rating = arrMovie[indexPath.row]["vote_average"] as! Int
        cell.rating.text = "Rating: " + String(rating)
        let overview = arrMovie[indexPath.row]["overview"] as! String
        cell.overview.text = overview
        let releaseDate = arrMovie[indexPath.row]["release_date"] as! String
        cell.releaseDate.text = releaseDate
        let posterImage = arrMovie[indexPath.row]["poster_path"] as! String
        let fullLinkImage = endPointPoster.appending(posterImage)
        cell.imgPoster.setImageWith(URL(string: fullLinkImage)!)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueToDetailVC", sender: self)
    }
}

