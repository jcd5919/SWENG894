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
    let title: [String?]
    let description: [String?]
    let link: [String?]
    
}

//Create the model that will contain the entirety of results that result from our Google search request

struct ItemsData{
    
    var allItems:[GoogleSearchModel]
    
}

//Create the model that will contain the entiredty of images from the google search request

struct SearchImages: Identifiable {
    
    let id = UUID()
    let image: [String?]
    
}

struct ImageData {
    
    var allImages: [SearchImages]
}
