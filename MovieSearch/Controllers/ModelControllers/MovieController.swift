//
//  MovieController.swift
//  MovieSearch
//
//  Created by Will morris on 5/17/19.
//  Copyright © 2019 devmtn. All rights reserved.
//

import UIKit

class MovieController {
    
    // Search for movie using search term
    static func searchMoviesFor(searchTerm: String, completion: @escaping ([Movie]) -> Void) {
        
        let baseURL = URL(string: "https://api.themoviedb.org/3")
        
        // Create the url with the right componenents
        guard var url = baseURL else { completion([]); return }
        
        url.appendPathComponent("search")
        url.appendPathComponent("movie")
        
        // Add the required Query items
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let apiQuery = URLQueryItem(name: "api_key", value: "16697161ca27a4bcdb2b46d4e669b6ec")
        let searchQuery = URLQueryItem(name: "query", value: searchTerm)
        
        components?.queryItems = [apiQuery, searchQuery]
        
        // Unwrap final url for fetching
        guard let finalURL = components?.url else { completion([]); return }
        
        // Create datatask to fetch data from url
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("There was an error fetching data: \(error.localizedDescription)")
                completion([])
                return
            }
            
            // Unwrap the data and return the array of results
            guard let data = data else { completion([]); return }
            
            do {
                let movie = try JSONDecoder().decode(TopLevelDict.self, from: data)
                completion(movie.results)
                return
            } catch {
                print("There was an error decoding: \(error) : \(error.localizedDescription)")
                completion([])
                return
            }
        }.resume()
    }
    
    // Find the image poster for specified movie
    static func fetchImageFor(movie: Movie, completion: @escaping (UIImage?) -> Void) {
        
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w500")
        
        // Get full url for image poster
        guard var url = baseURL else { completion(nil); return }
        guard let image = movie.image else { completion(nil); return }
        
        url.appendPathComponent(image)
        
        // Create datatask to fetch, convert, and return it as a UIImage
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("There was an error fetching data: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else { completion(nil); return }
            
            let image = UIImage(data: data)
            completion(image)
            return
        }.resume()
    }
}
