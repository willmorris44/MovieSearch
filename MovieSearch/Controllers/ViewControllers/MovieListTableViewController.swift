//
//  MovieListTableViewController.swift
//  MovieSearch
//
//  Created by Will morris on 5/17/19.
//  Copyright © 2019 devmtn. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    // Holds array of movies fetched from search bar
    var results: [Movie] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Creates cell and type casts it as a MovieTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell
        
        // Tell cell what movie it is and set its image
        let movie = results[indexPath.row]
        cell?.movie = movie
        cell?.posterImageView.image = nil
        
        MovieController.fetchImageFor(movie: movie) { (image) in
            DispatchQueue.main.async {
                cell?.posterImageView.image = image
            }
        }
        
        return cell ?? UITableViewCell()
    }
}

// MARK: - Delegates

// Confrom to search bar delegate and set results equal to what is in the search bar when the search button is clicked
extension MovieListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchterm = searchBar.text else { return }
        
        MovieController.searchMoviesFor(searchTerm: searchterm) { (results) in
            self.results = results
            
            DispatchQueue.main.async {
                self.title = searchterm
                self.tableView.reloadData()
            }
        }
    }
}
