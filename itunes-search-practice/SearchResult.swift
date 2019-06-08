//
//  SearchResult.swift
//  itunes-search-practice
//
//  Created by Dongwoo Pae on 6/7/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation

struct SearchResults: Codable {
    var results: [SearchResult]
}
    
struct SearchResult: Codable {
    var title: String?
    var creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
        }
    }
