//
//  URecipesTableViewController.swift
//  PhotoFood
//
//  Created by Joseph Duckwall on 10/31/24.
//


import UIKit
import CoreData

class URecipesTableViewController: UIViewController {
  // MARK: - Properties
  @IBOutlet private weak var tableView: UITableView!
  private lazy var coreDataStack = CoreDataStack()
  private lazy var recipeService = URecipesService(
    managedObjectContext: coreDataStack.mainContext,
    coreDataStack: coreDataStack)
  private var recipes: [UserRecipe]?
  private let segueIdentifier = "showDetail"
  private let cellIdentifier = "Cell"

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    recipes = recipeService.getRecipes()
    tableView.reloadData()
  }

  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard
      segue.identifier == segueIdentifier,
      let navigationController = segue.destination as? UINavigationController,
      let controller = navigationController.topViewController as? UserRecipeViewController
      else {
        return
    }

    navigationController.modalPresentationStyle = .fullScreen
    controller.recipeService = recipeService
    if let indexPath = tableView.indexPathForSelectedRow, let existingRecipe = recipes?[indexPath.row] {
      controller.recipe = existingRecipe
    }
  }

  // MARK: - Actions
  @IBAction func add(_ sender: Any) {
    performSegue(withIdentifier: segueIdentifier, sender: nil)
  }
    @IBAction func back(_ sender: Any) {
        guard let svc = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") else{
            print("failed to get svc from storyboard")
            return
        }
        let navVC = UINavigationController(rootViewController: svc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension URecipesTableViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: segueIdentifier, sender: nil)
  }
}

// MARK: - UITableViewDataSource
extension URecipesTableViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return recipes?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    guard let recipe = recipes?[indexPath.row] else {
      return cell
    }
    cell.textLabel?.text = recipe.name
    return cell
  }

  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    guard
      let recipe = recipes?[indexPath.row],
      editingStyle == .delete
      else {
        return
    }
    recipes?.remove(at: indexPath.row)
    recipeService.delete(recipe)
    tableView.deleteRows(at: [indexPath], with: .automatic)
  }
}

