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
    var answers = Answers.correct
    
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var userPasswordTextField: UITextField!

    @IBAction func loginAction(_ sender: UIButton) {
    }
    
    @IBAction func forgotNameAction(_ sender: UIButton) {
        answers = .forgotName
    }
    
    @IBAction func forgotPasswordAction(_ sender: UIButton) {
        answers = .forgotPassword
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
    }
    
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

