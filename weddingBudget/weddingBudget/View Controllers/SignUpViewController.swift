//
//  SignUpViewController.swift
//  weddingBudget
//
//  Created by Elizabeth Wingate on 4/27/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    func setUpElements() {
        
        errorLabel.alpha = 0

        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
    }
    
    func validateFields() -> String? {
        
     if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
        return "Please fill in all fields."
  }
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
    let error = validateFields()
            
    if error != nil {
  
    showError(error!)
        
    } else {
             
       let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
       let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
       let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
       let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                
  
       Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                    
        // Check for errors
        if err != nil {
                        
        self.showError("Error creating user")
        
        } else {
            
            let db = Firestore.firestore()
                            
            db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid ]) { (error) in
                                
            if error != nil {
           
            self.showError("Error saving user data")
        }
}
          self.transitionToHome()
    }
}
    }
}
    func showError(_ message:String) {
                
        errorLabel.text = message
        errorLabel.alpha = 1
    }
            
    func transitionToHome() {
                
        let tabBarController = storyboard?.instantiateViewController(identifier:
            Constants.Storyboard.tabBarController) as? TabBarController
                
        view.window?.rootViewController = tabBarController
        view.window?.makeKeyAndVisible()
                
    }
}
