//
//  GoogleSearchModel.swift
//  PhotoFood
//
//  Created by Joseph Duckwall on 10/1/24.
//

import Foundation

//Create the model that will contain the relevant information for a single search result

struct GoogleSearchModel: Identifiable {
    
    let id = UUID()
    let name: [String?]
    let desc: [String?]
    let urlLink: [String?]
    
}

//Create the model that will contain the entirety of results that result from our Google search request

struct SearchResults{
    
    var results:[GoogleSearchModel]
    
}
