//
//  LoginViewController.swift
//  weddingBudget
//
//  Created by Elizabeth Wingate on 4/27/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    func setUpElements() {

        errorLabel.alpha = 0

        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
        
    }
    
    @IBAction func loginTapped(_ sender: Any) {
    
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
            if error != nil {
            // Couldn't sign in
            self.errorLabel.text = error!.localizedDescription
            self.errorLabel.alpha = 1
       } else {
                    
            let tabBarController = self.storyboard?.instantiateViewController(identifier:
                    Constants.Storyboard.tabBarController) as? TabBarController
                        
            self.view.window?.rootViewController = tabBarController
            self.view.window?.makeKeyAndVisible()
        }
     }
   }
}
