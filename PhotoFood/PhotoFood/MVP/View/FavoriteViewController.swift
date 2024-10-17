//
//  FavoriteViewController.swift
//  PhotoFood
//
//  Created by Joseph Duckwall on 9/27/24.
//

import Foundation
import UIKit

class FavoriteViewController: UIViewController{
    
    override func viewDidLoad(){
        super.viewDidLoad()
        title = "List of Favorites"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", 
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(backSelf))
    }
    
    @objc private func backSelf(){
        dismiss(animated: true, completion: nil)
    }
}

