//
//  FavoriteViewController.swift
//  PhotoFood
//
//  Created by Joseph Duckwall on 9/27/24.
//

import Foundation
import UIKit
import CoreData

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier:"cell")
        return table
    }()
    
    private var models = [UserRecipe]()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        title = "My Recipes"
        view.addSubview(tableView)
        getAllRecipes()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(backSelf))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(didTapAdd))
      
        }
    
    @objc private func didTapAdd() {
        let alert = UIAlertController(title: "New Recipe",
                                      message: "Enter new recipe",
                                      preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: {[weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            self?.createRecipe(name: text)
        }))
        present(alert, animated: true)
    }
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = models[indexPath.row]
    
        let sheet = UIAlertController(title: "Edit",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            let alert = UIAlertController(title: "Edit Recipe",
                                          message: "Enter your recipe",
                                          preferredStyle: .alert)
            alert.textFields?.first?.text = item.name
            alert.addTextField(configurationHandler: nil)
            alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: {[weak self] _ in
                guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else {
                    return
                }
                self?.updateRecipe(item: item, newName: newName, newInstructions: "", newNotes: "")
            }))
            self.present(alert, animated: true)
        }))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteRecipe(item: item)
        }))

        present(sheet, animated: true)
    }
    
    
    //Core Data
    
    func getAllRecipes() {
        
        do {
            models = try context.fetch(UserRecipe.fetchRequest())
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        } catch {
            //error
        }
        
    }
    
    func createRecipe(name: String){
        
        let newRecipe = UserRecipe(context: context)
        newRecipe.name = name
        newRecipe.createdAt = Date()
        
        do {
            try context.save()
            getAllRecipes()
        } catch {
            //error
        }
        
    }
    
    func deleteRecipe(item: UserRecipe){
        
        context.delete(item)
        do {
            try context.save()
            getAllRecipes()
        } catch {
            //error
        }
        
    }
        
    
    func updateRecipe(item: UserRecipe, newName: String, newInstructions: String, newNotes: String){
        item.name = newName
        item.instructions = newInstructions
        item.notes = newNotes
        
        context.delete(item)
        do {
            try context.save()
        } catch {
            //error
        }
        
    }
    
    @objc private func backSelf(){
        dismiss(animated: true, completion: nil)
    }
    
}

