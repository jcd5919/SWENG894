//
//  SearchPresenter.swift
//  PhotoFood
//
//  Created by Joseph Duckwall on 10/10/24.
//

import Foundation
import UIKit

protocol PresenterView: AnyObject {
    func updateSearchUI()
}

class SearchPresenter {
    weak var presenterView: PresenterView?
    
    var foodFilter: String!
    var typeFilter: String!
    
    var ingredient1: String!
    var ingredient2: String!
    var ingredient3: String!
    var ingredient4: String!
    
    init(view:PresenterView){
        self.presenterView = view
    }
    
    func searchButtonClicked(){
        print("Food Filter: " + foodFilter)
        print("Type Filter: " + typeFilter)
        print("Ingredient1: " + ingredient1)
        print("Ingredient2: " + ingredient2)
        print("Ingredient3: " + ingredient3)
        print("Ingredient4: " + ingredient4)

    }
}
