//
//  PhotoSelectorViewController+PhotoPicker.swift
//  PhotoFood
//
//  Created by Joseph Duckwall on 11/19/24.
//  This is based on the image classifier sample in Apples CreateML

import Foundation
import PhotosUI

extension PhotoSelectorViewController: PHPickerViewControllerDelegate {
    //Create a controller that lets a user select a photo from their photo library
    var photoPicker: PHPickerViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = PHPickerFilter.images

        let photoPicker = PHPickerViewController(configuration: config)
        photoPicker.delegate = self

        return photoPicker
    }

    //This method occurs once a user has successfully finished picking a photo from their library
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: false)

        guard let result = results.first else {
            return
        }

        result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
            if let error = error {
                print("Photo picker error: \(error)")
                return
            }

            guard let photo = object as? UIImage else {
                fatalError("The Photo Picker's image isn't a/n \(UIImage.self) instance.")
            }

            self.userSelectedPhoto(photo)
        }
    }
}
