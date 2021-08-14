//
//  LoginViewController.swift
//  Sneak Cinema
//
//  Created by Ahmed Yasser on 14/07/2021.
//

import UIKit
import SkyFloatingLabelTextField
import NVActivityIndicatorView
import dotLottie
import Lottie

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextFieldWithIcon!
    
    let validator = Validator()
    @IBOutlet weak var activityIndicator: AnimationView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        DotLottie.load(name: "PopCornLoading") { (animation, file) in
            if let animation = animation {
                self.activityIndicator.animation = animation
            }else{
                print("Error loading lottie")
            }
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func login(_ sender: GradientButton) {
        sender.isEnabled = false
        if validateFields() {
            self.activityIndicator.play()
            CinemaNetwork.cinemaRequest(NConstants.createRequestToken,self) { token, error in
                if error != nil {
                    self.activityIndicator.stop()
                    sender.isEnabled = true
                } else {
                    print("Created The Request Token \(token?.request_token ?? "")")
                    CinemaNetwork.cinemaRequest(NConstants.createSessionWithLogin,self,["request_token": token?.request_token ?? "", "username" : self.emailTextField.text ?? "" , "password" : self.passwordTextField.text ?? ""],.post) { session, error in
                        self.activityIndicator.stop()
                        sender.isEnabled = true
                        if error == nil {
                            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CinemaTabbar")
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
            }
        } else {
            sender.isEnabled = true
        }
    }
    
    @IBAction func loginAsGuest(_ sender: UIButton) {
        sender.isEnabled = false
        self.activityIndicator.play()
        CinemaNetwork.cinemaRequest(NConstants.guestSession, self) { session, error in
            self.activityIndicator.stop()
            sender.isEnabled = true
            if error == nil {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CinemaTabbar")
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    private func validateFields() -> Bool {
        let emailError = validator.validate(input: emailTextField, with: [.notEmpty])
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

