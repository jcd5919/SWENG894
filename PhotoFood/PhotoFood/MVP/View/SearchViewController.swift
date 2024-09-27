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
    

    @IBAction func cameraButton(_ sender: Any) {
        
        guard let cvc = storyboard?.instantiateViewController(withIdentifier: "cameraController") else{
            print("failed to get cvc from storyboard")
            return
        }
        let navVC = UINavigationController(rootViewController: cvc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    @IBAction func searchTap(_ sender: Any) {
        print("To be added at later sprint")
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
}
