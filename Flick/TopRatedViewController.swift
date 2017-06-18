//
//  TopRatedViewController.swift
//  Flick
//
//  Created by admin on 6/18/17.
//  Copyright © 2017 nhp. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class TopRatedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate, UISearchResultsUpdating  {
    // MARK: *** Local variables
    let refreshControl = UIRefreshControl()
    let searchController = UISearchController(searchResultsController: nil)
    var arrMovie = [AnyObject]()
    let endPointPoster = "https://image.tmdb.org/t/p/w342"
    var filteredArray = [AnyObject]()
    // MARK: *** Data Models
    
    // MARK: *** UI Elements
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var alert: UILabel!
    
    // MARK: *** UI Events
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert.isHidden = true
        refreshControl.addTarget(self, action: #selector(ViewController.fetchData), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        
        fetchData()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

    }
    
    func fetchData(){
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)")
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
                            // Hide HUD once the network request comes back (must be done on main UI thread)
                            MBProgressHUD.hide(for: self.view, animated: true)
                            self.alert.isHidden = true
                            self.arrMovie = results
                            self.tableView.reloadData()
                            self.refreshControl.endRefreshing()
                        }
                    }
                }
                if error != nil{
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.alert.isHidden = false
                }
            })
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailVCCC" {
            let indexPath = tableView.indexPathForSelectedRow
            let dest = segue.destination as! DetailViewController
            if searchController.isActive && searchController.searchBar.text != "" {
                dest.selectedMovie = filteredArray[(indexPath?.row)!]
            }else{
                dest.selectedMovie = arrMovie[(indexPath?.row)!]
            }
        }
    }


    // MARK: *** UITableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //return number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredArray.count
        }else{
            return self.arrMovie.count
        }
    }
    //set data for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("MoTableViewCell", owner: self, options: nil)?.first as! MoTableViewCell
        
        if searchController.isActive && searchController.searchBar.text != "" {
            let movie = filteredArray[indexPath.row]
            let title = movie["original_title"] as! String
            cell.title.text = title
            let rating = movie["vote_average"] as! Float
            cell.rating.text = "Rating: " + String(rating)
            let overview = movie["overview"] as! String
            cell.overview.text = overview
            let releaseDate = movie["release_date"] as! String
            cell.releaseDate.text = releaseDate
            let posterImage = movie["poster_path"] as! String
            let fullLinkImage = endPointPoster.appending(posterImage)
            cell.posterImage.setImageWith(URL(string: fullLinkImage)!)
            
        }else{
            let title = arrMovie[indexPath.row]["original_title"] as! String
            cell.title.text = title
            let rating = arrMovie[indexPath.row]["vote_average"] as! Float
            cell.rating.text = "Rating: " + String(rating)
            let overview = arrMovie[indexPath.row]["overview"] as! String
            cell.overview.text = overview
            let releaseDate = arrMovie[indexPath.row]["release_date"] as! String
            cell.releaseDate.text = releaseDate
            let posterImage = arrMovie[indexPath.row]["poster_path"] as! String
            let fullLinkImage = endPointPoster.appending(posterImage)
            cell.posterImage.setImageWith(URL(string: fullLinkImage)!)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueToDetailVCCC", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func filterContentForSearch(searchString: String, forKey: String) {
        filteredArray.removeAll()
        if forKey == "name"{
            for movie in arrMovie {
                let copyMovie = movie
                let temp = copyMovie["original_title"] as! String
                if temp.lowercased().contains(searchString.lowercased()){
                    filteredArray += [copyMovie]
                }
            }
        }
        
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearch(searchString: searchController.searchBar.text!, forKey: "name")
        tableView.reloadData()
    }
    



}
