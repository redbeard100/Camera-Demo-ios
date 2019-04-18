//
//  ViewController.swift
//  Camera Demo
//
//  Created by Soumil on 18/04/19.
//  Copyright © 2019 LPTP233. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageViewer: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    var newImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /* Description: Opening Camera Action
     - Parameter keys: sender
     - Returns: No Parameter
     */
    @IBAction func takeImageAction(_ sender: UIButton) {
        saveButton.isEnabled = false
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }else {
            print("No Camera found")
            let alert = UIAlertController(title: "No Camera found", message: "Unable to take Image", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    /* Description: Show the picked image in Imageview
     - Parameter keys: picker, info
     - Returns: No Parameter
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            imageViewer.contentMode = .scaleToFill
            imageViewer.image = pickedImage
            newImage = pickedImage
            saveButton.isEnabled = true
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    /* Description: Save Image button action
     - Parameter keys: sender
     - Returns: No Parameter
     */
    @IBAction func saveImageAction(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(newImage!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        dismiss(animated: true, completion: nil)
    }
    
    /* Description: Save Image to Photos
     - Parameter keys: image, error, contextInfo
     - Returns: No Parameter
     */
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let errorAlert = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
            present(errorAlert, animated: true)
        } else {
            let successAlert = UIAlertController(title: "Saved!", message: "Your image has been saved to your photos.", preferredStyle: .alert)
            successAlert.addAction(UIAlertAction(title: "OK", style: .default))
            present(successAlert, animated: true)
            saveButton.isEnabled = false
        }
    }
    
}

