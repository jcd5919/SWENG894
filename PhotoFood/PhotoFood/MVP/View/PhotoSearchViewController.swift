//
//  PhotoSearchViewController.swift
//  PhotoFood
//
//  Created by Joseph Duckwall on 11/4/24.
//


import Foundation
import UIKit
import SwiftUI



class PhotoSearchViewController: UIViewController, UITextFieldDelegate, PresenterView{
    func updateSearchUI() {
        
    }
    
    @IBOutlet weak var foodFilterButton: UIButton!
    @IBOutlet weak var dietFilterButton: UIButton!

    var searchIngredients = ""
    @IBOutlet weak var currentIngredients: UILabel!
    
    lazy var presenter = SearchPresenter(view:self)
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setUpFoodFilterButton()
        setUpDietFilterButton()
        currentIngredients.text = searchIngredients
    }
    
    @IBAction func cameraButton(_ sender: Any) {
        if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "PhotoSelectorViewController") as? PhotoSelectorViewController {
            destinationVC.currentSearch = "\(searchIngredients) "
            navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
    
    func setUpFoodFilterButton(){
        
        let typeChoices = {(action: UIAction)
            in print(action.title)}
        foodFilterButton.menu = UIMenu(children: [
            UIAction(title: "None", state: .on, handler: typeChoices),
            UIAction(title: "Breakfast", handler: typeChoices),
            UIAction(title: "Lunch", handler: typeChoices),
            UIAction(title: "Dinner", handler: typeChoices),
            UIAction(title: "Dessert", handler: typeChoices)])
        foodFilterButton.showsMenuAsPrimaryAction = true
        foodFilterButton.changesSelectionAsPrimaryAction = true
    }
    
    func setUpDietFilterButton(){
        
        let dietChoices = {(action: UIAction)
            in print(action.title)}
        dietFilterButton.menu = UIMenu(children: [
            UIAction(title: "None", state: .on, handler: dietChoices),
            UIAction(title: "Vegetarian", handler: dietChoices),
            UIAction(title: "Vegan", handler: dietChoices),
            UIAction(title: "Gluten-Free", handler: dietChoices),
            UIAction(title: "Dairy-Free", handler: dietChoices),])
        dietFilterButton.showsMenuAsPrimaryAction = true
        dietFilterButton.changesSelectionAsPrimaryAction = true
    }
    
    @IBAction func searchTap(_ sender: Any) {
        presenter.foodFilter = foodFilterButton.currentTitle
        presenter.typeFilter = dietFilterButton.currentTitle
        presenter.ingredient1 = searchIngredients
        searchIngredients = ""
        presenter.ingredient2 = ""
        presenter.ingredient3 = ""
        presenter.ingredient4 = ""

        presenter.searchButtonClicked()
        let searchURL = presenter.searchURL
        let hostingController = UIHostingController(rootView: SearchContentView(searchWord: searchURL!))
        hostingController.modalPresentationStyle = .fullScreen
        present(hostingController, animated: true)
}
    
    @IBAction func cancelSearch(_ sender: Any) {
        guard let svc = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") else{
            print("failed to get svc from storyboard")
            return
        }
        searchIngredients = ""
        let navVC = UINavigationController(rootViewController: svc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
}

    
