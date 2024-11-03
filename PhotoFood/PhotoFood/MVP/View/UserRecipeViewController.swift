//
//  UserRecipeViewController.swift
//  PhotoFood
//
//  Created by Joseph Duckwall on 10/31/24.
//

import UIKit

class UserRecipeViewController: UITableViewController {
  // MARK: - Properties
  var recipe: UserRecipe?
  var recipeService: URecipesService?
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var instructionsTextField: UITextView!
  @IBOutlet weak var notesTextField: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // disables cell highlighting
        tableView.allowsSelection = false
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        if let recipe = recipe {
            nameTextField.text = recipe.name
            instructionsTextField.text = recipe.instructions
            notesTextField.text = recipe.notes
        }
    }

  // MARK: - Actions
  @IBAction func cancel(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }

  @IBAction func save(_ sender: Any) {
      let name = nameTextField.text ?? ""
      let instructions = instructionsTextField.text ?? ""
      let notes = notesTextField.text ?? ""

    if let recipe = recipe {
      recipe.name = name
      recipe.instructions = instructions
      recipe.notes = notes
      dismiss(animated: true, completion: nil)
    } else {
      recipeService?.add(
        name,
        instructions: instructions,
        notes: notes,
        createdAt: Date())
      dismiss(animated: true, completion: nil)
    }
  }
}
