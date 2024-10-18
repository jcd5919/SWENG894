//
//  SearchViewController.swift
//  PhotoFood
//
//  Created by Joseph Duckwall on 9/19/24.
//

import Foundation
import UIKit
import SwiftUI

protocol SearchView: AnyObject {
}

class SearchViewController: UIViewController, UITextFieldDelegate, PresenterView{
    func updateSearchUI() {
    }
    
    
    
    @IBOutlet weak var foodFilterButton: UIButton!
    @IBOutlet weak var dietFilterButton: UIButton!
    
    
    @IBOutlet weak var ingredient1Box: UITextField!
    @IBOutlet weak var ingredient2Box: UITextField!
    @IBOutlet weak var ingredient3Box: UITextField!
    @IBOutlet weak var ingredient4Box: UITextField!
    
    lazy var presenter = SearchPresenter(view:self)
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setUpFoodFilterButton()
        setUpDietFilterButton()
        self.ingredient1Box.delegate = self
        self.ingredient2Box.delegate = self
        self.ingredient3Box.delegate = self
        self.ingredient4Box.delegate = self
    }
    
    @IBAction func cameraButton(_ sender: Any) {
        
        guard let cvc = storyboard?.instantiateViewController(withIdentifier: "cameraController") else{
            print("failed to get cvc from storyboard")
            return
        }
        let navVC = UINavigationController(rootViewController: cvc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
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
        presenter.ingredient1 = ingredient1Box.text
        presenter.ingredient2 = ingredient2Box.text
        presenter.ingredient3 = ingredient3Box.text
        presenter.ingredient4 = ingredient4Box.text
        presenter.searchButtonClicked()
        let searchURL = presenter.searchURL
        let hostingController = UIHostingController(rootView: SearchContentView(searchWord: searchURL!))
        hostingController.modalPresentationStyle = .fullScreen
        present(hostingController, animated: true)
}
    
    @IBAction func favoritesButton(_ sender: Any) {
        guard let fvc = storyboard?.instantiateViewController(withIdentifier: "favoriteController") else{
            print("failed to get fvc from storyboard")
            return
        }
        let navVC = UINavigationController(rootViewController: fvc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}

    
