//
//  PhotoSelectorView.swift
//  PhotoFood
//
//  Created by Joseph Duckwall on 11/19/24.
//  This is based on the image classifier sample in Apples CreateML

import Foundation
import UIKit

class PhotoSelectorViewController: UIViewController {
    var firstRun = true

    /// A predictor instance that uses Vision and Core ML to generate prediction strings from a photo.
    let imagePredictor = ImagePredictor()
    var currentSearch = ""
    /// The largest number of predictions the main view controller displays the user.
    let predictionsToShow = 1
    // MARK: Main storyboard outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var predictionLabel: UILabel!
    @IBOutlet weak var okayButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        okayButton.isHidden = true
        okayButton.isEnabled = false
    }
}

extension PhotoSelectorViewController {
    //This occurs when the user taps the Camera Button
    @IBAction func CameraButtonPressed() {
        // Show options for the source picker only if the camera is available.
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            present(photoPicker, animated: false)
            return
        }

        present(cameraPicker, animated: false)
    }

    // This occurs when the user taps the Library Button
    @IBAction func photoLibraryButtonPressed() {
        present(photoPicker, animated: false)
    }
    
    @IBAction func okayButtonPressed(){
        
        if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "PhotoSearchViewController") as? PhotoSearchViewController {
            if currentSearch == "" {
                currentSearch = predictionLabel.text!
            }
            else {
                currentSearch = "\(currentSearch) + \(predictionLabel.text!)"

            }
            destinationVC.searchIngredients = currentSearch
            navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
}

extension PhotoSelectorViewController {

    func updateImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }

    //Update the prediction label to the current message
    func updatePredictionLabel(_ message: String) {
        DispatchQueue.main.async {
            self.predictionLabel.text = message
        }

        if firstRun {
            DispatchQueue.main.async {
                //After the first run, change the firstRun variable
                //Also enable the okay button that required a first prediction
                self.firstRun = false
                self.predictionLabel.superview?.isHidden = false
                self.okayButton.isEnabled = true
                self.okayButton.isHidden = false
            }
        }
    }
    //This occurs when a user selects an image from the photo library.
    func userSelectedPhoto(_ photo: UIImage) {
        updateImage(photo)
        updatePredictionLabel("Making predictions for the photo...")

        DispatchQueue.global(qos: .userInitiated).async {
            self.classifyImage(photo)
        }
    }

}

extension PhotoSelectorViewController {

    //This classifies an image by sending it to the imagePredictor
    private func classifyImage(_ image: UIImage) {
        do {
            try self.imagePredictor.makePredictions(for: image,
                                                    completionHandler: imagePredictionHandler)
        } catch {
            print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
        }
    }

    //This occurs when the model generates a prediction
    private func imagePredictionHandler(_ predictions: [ImagePredictor.Prediction]?) {
        guard let predictions = predictions else {
            updatePredictionLabel("No predictions. (Check console log.)")
            return
        }

        let formattedPredictions = formatPredictions(predictions)

        let predictionString = formattedPredictions.joined(separator: "\n")
        updatePredictionLabel(predictionString)
    }

    //This converts the predictions into a readable format
    private func formatPredictions(_ predictions: [ImagePredictor.Prediction]) -> [String] {
        // Vision sorts the classifications in descending confidence order.
        let predictionList: [String] = predictions.prefix(predictionsToShow).map { prediction in
            var name = prediction.classification

            // For classifications with more than one name, keep the one before the first comma.
            if let firstComma = name.firstIndex(of: ",") {
                name = String(name.prefix(upTo: firstComma))
            }

            return "\(name)"
        }
        return predictionList
    }
}
