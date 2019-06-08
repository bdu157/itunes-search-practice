//
//  SearchResultController.swift
//  itunes-search-practice
//
//  Created by Dongwoo Pae on 6/7/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/")!
    
    var searchResults: [SearchResult] = []

    func performSearch(searchTerm:String, resultType: ResultType, completion:@escaping (Error?)-> Void) {
        //https://itunes.apple.com/search?term=jack+johnson&entity=musicVideo   queryItems
        let searchURL = baseURL.appendingPathComponent("search")
        
        var urlComponents = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let entityQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, entityQueryItem]
        guard let requestURL = urlComponents?.url else {
            NSLog("no requested URL")
            completion(NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("there is an error: \(error)")
                completion(NSError())
                return
            }
            
            guard let data = data else {
                NSLog("there is an error: no data")
                completion(NSError())
                return
            }
            let jsonDecoder = JSONDecoder()
            
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
            } catch {
                NSLog("unable to complete \(error)")
            }
            completion(nil)
            
        }.resume()
    }
}
