//
//  HomeViewController.swift
//  weddingBudget
//
//  Created by Elizabeth Wingate on 4/27/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import UIKit
import Photos
import CoreImage

class HomeViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    let picker = UIDatePicker()
    var imagePicker = UIImagePickerController()

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var weddingDatePicker: UITextField!
    
    override func viewDidLoad() {
            super.viewDidLoad()
    
            createDatePicker()
      }

    func createDatePicker() {
            
            // toolbar
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            
            //done button
            let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
            toolbar.setItems([done], animated: false)
            
           weddingDatePicker.inputAccessoryView = toolbar
           weddingDatePicker.inputView = picker
            
            picker.datePickerMode = .date
        }
        
        @objc func donePressed() {
            
            // format date
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            let dateString = formatter.string(from: picker.date)
            
            weddingDatePicker.text = "\(dateString)"
            self.view.endEditing(true)
            
        }
        
        @IBAction func saveButton(_ sender: Any) {
        
        }
        
        @IBAction func addPhotoButton(_ sender: Any) {
         
            let image = UIImagePickerController()
            image.delegate = self
            
            image.sourceType = UIImagePickerController.SourceType.photoLibrary
            image.allowsEditing = false
            
            self.present(image, animated: true) {
            }

        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                
                img.image = image }
            else {
            
            }
            self.dismiss(animated: true, completion: nil)
        }

}
