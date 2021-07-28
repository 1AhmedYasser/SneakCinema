//
//  LoginViewController.swift
//  Sneak Cinema
//
//  Created by Ahmed Yasser on 14/07/2021.
//

import UIKit
import SkyFloatingLabelTextField

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextFieldWithIcon!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func login(_ sender: GradientButton) {
        validateFields()
    }
    
    private func validateFields() {
        if emailTextField.text!.isEmpty {
            emailTextField.errorMessage = "Empty Field"
        } else {
            emailTextField.errorMessage = ""
        }
        
        if passwordTextField.text!.isEmpty {
            passwordTextField.errorMessage = "Empty Field"
        } else {
            passwordTextField.errorMessage = ""
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("hi")
        return true
    }
    
    @objc func textFieldDidChange(_ textfield: UITextField) {
        if let text = textfield.text {
            if let floatingLabelTextField = emailTextField {
                if(text.count < 3) {
                    floatingLabelTextField.errorMessage = "Invalid email"
                }
                else {
                    // The error message will only disappear when we reset it to nil or empty string
                    floatingLabelTextField.errorMessage = ""
                }
            }
        }
    }
}

