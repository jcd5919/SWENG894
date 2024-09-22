//
//  SearchViewController.swift
//  PhotoFood
//
//  Created by Joseph Duckwall on 9/19/24.
//

import Foundation
import UIKit

class SearchViewController: UIViewController{
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    @IBAction func addTextBox(sender: UIButton){
        let alertController = UIAlertController(title: "Welcome to my first test", message: "Hello testers", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
}
