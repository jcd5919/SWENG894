//
//  PhotoSelctorViewController+CameraPicker.swift
//  PhotoFood
//
//  Created by Joseph Duckwall on 11/19/24.
//  This is based on the image classifier sample in Apples CreateML

import Foundation
import UIKit

extension PhotoSelectorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //Create a view that allows the user to use the camera's viewfinder
    var cameraPicker: UIImagePickerController {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .camera
        return cameraPicker
    }

    //This delegate method occurs when the user takes a photo with the camera
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: false)

        // Always return the original image.
        guard let originalImage = info[UIImagePickerController.InfoKey.originalImage] else {
            fatalError("Picker didn't have an original image.")
        }

        guard let photo = originalImage as? UIImage else {
            fatalError("The (Camera) Image Picker's image isn't a/n \(UIImage.self) instance.")
        }

        userSelectedPhoto(photo)
    }
}
