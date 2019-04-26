//
//  ViewController.swift
//  Login
//
//  Created by Michael Tseitlin on 4/24/19.
//  Copyright © 2019 Michael Tseitlin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let userName = "Michael Tseitlin"
    let password = "Password"
    var answers = Answers.uncorrect
    
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var userPasswordTextField: UITextField!
    
    @IBAction func loginAction(_ sender: UIButton) {
        answers = .correct
    }
    
    @IBAction func forgotNameAction(_ sender: UIButton) {
        answers = .forgotName
    }
    
    @IBAction func forgotPasswordAction(_ sender: UIButton) {
        answers = .forgotPassword
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {}
}

// MARK: - Navigation
extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? SecondViewController {
            
            switch answers {
            case .correct, .uncorrect:
                if userNameTextField.text == userName && userPasswordTextField.text == password {
                    destination.message = "Hello, \(userNameTextField.text!)!"
                } else if userNameTextField.text != userName && userPasswordTextField.text == password {
                    destination.message = "Wrong username!"
                } else if userNameTextField.text == userName && userPasswordTextField.text != password {
                    destination.message = "Wrong password!"
                } else {
                    destination.message = "Wrong username and password!"
                }
            case .forgotName:
                destination.message = "Your username is - \(userName)"
            case .forgotPassword:
                destination.message = "Your password is - \(password)"
            }
        }
    }
}

// MARK: - UI Text Field Delegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        performSegue(withIdentifier: "loginSegue", sender: Any?.self)
        self.view.endEditing(true)
        return false
        
    }
}

// MARK: - Hide the keyboard when we touch outside
extension ViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
