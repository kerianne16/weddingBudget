//
//  SettingsViewController.swift
//  weddingBudget
//
//  Created by Elizabeth Wingate on 4/28/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import UIKit
import Photos
import CoreImage

class SettingsViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var brideTextfield: UITextField!
    @IBOutlet weak var groomTextfield: UITextField!
    @IBOutlet weak var weddingDateTextfield: UITextField!
    
    let picker = UIDatePicker()
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
        imagePicker.delegate = self
    }
    
    func createDatePicker() {
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //done button
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        
        weddingDateTextfield.inputAccessoryView = toolbar
        weddingDateTextfield.inputView = picker
        
        picker.datePickerMode = .date
    }
    
    @objc func donePressed() {
        
        // format date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: picker.date)
        
        weddingDateTextfield.text = "\(dateString)"
        self.view.endEditing(true)
        
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        
    }
    
    @IBAction func addPhotoButton(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            img.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}