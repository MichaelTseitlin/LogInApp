//
//  ViewController.swift
//  Login
//
//  Created by Michael Tseitlin on 4/24/19.
//  Copyright © 2019 Michael Tseitlin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let userName = "Michael Tseitlin"
    private let password = "Password"
    private var answers = Answers.uncorrect
    
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var userPasswordTextField: UITextField!
        
    override func viewDidLoad() {
        userNameTextField.autocorrectionType = .no
        userPasswordTextField.autocorrectionType = .no
        
        addObservesForKeyboard()
    }
    
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
        if textField == userNameTextField {
            userPasswordTextField.becomeFirstResponder()
            return false
        } else if textField == userPasswordTextField {
            self.view.endEditing(true)
                performSegue(withIdentifier: "loginSegue", sender: UIButton.self)
            return true
        }
        return true
    }
}

// MARK: - Hide the keyboard when we touch outside
extension ViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

// MARK: - Solving the overlap problem with view
extension ViewController {
    private func addObservesForKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 2
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
