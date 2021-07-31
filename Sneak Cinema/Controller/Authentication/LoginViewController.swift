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
    
    let validator = Validator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func login(_ sender: GradientButton) {
        if validateFields() {
            CinemaNetwork.cinemaRequest(NConstants.createRequestToken) { session, error in
                if let error = error {
                    print(error)
                } else {
                    print("el request token ya m3lm \(session?.request_token  ?? "")")
                }
            }
        }
    }
    
    private func validateFields() -> Bool {
        let emailError = validator.validate(input: emailTextField, with: [.notEmpty, .validEmail])
        let passwordError = validator.validate(input: passwordTextField, with: [.notEmpty])
        emailTextField.errorMessage = !emailError.isEmpty ? emailError : ""
        passwordTextField.errorMessage = !passwordError.isEmpty ? passwordError : ""
    
        return emailError.isEmpty && passwordError.isEmpty ? true : false
    }
}

extension LoginViewController: UITextFieldDelegate {

    @objc func textFieldDidChange(_ textfield: SkyFloatingLabelTextFieldWithIcon) {
        textfield.errorMessage = ""
    }
}

