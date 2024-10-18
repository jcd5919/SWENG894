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
    
    var searchURL: String!
    
    init(view:PresenterView){
        self.presenterView = view
    }
    

    func searchButtonClicked(){
        self.searchURL = createSearch(foodFilter: foodFilter, typeFilter: typeFilter, ingredient1: ingredient1, ingredient2: ingredient2, ingredient3: ingredient3, ingredient4: ingredient4)
    
    }
    
    
    func createSearch(foodFilter: String = "None", typeFilter: String = "None", ingredient1: String, ingredient2: String = "", ingredient3: String = "", ingredient4: String = "")-> String {
        var filter = false
        var search = ""
        if foodFilter != "None" {
            search += foodFilter
            filter = true
        }
        if typeFilter != "None" {
            search += "+" + typeFilter
            filter = true
        }
        if (filter){
            search += "+" + ingredient1
        }
        else{
            search += ingredient1
        }        
        if ingredient2 != "" {
            search += "+" + ingredient2
        }
        if ingredient3 != "" {
            search += "+" + ingredient3
        }
        if ingredient4 != "" {
            search += "+" + ingredient4
        }
        search += "+recipes"
        
        return search
    }
    

}
