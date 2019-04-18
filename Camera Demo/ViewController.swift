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
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func takeImageAction(_ sender: UIButton) {
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            imageViewer.contentMode = .scaleToFill
            imageViewer.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}

