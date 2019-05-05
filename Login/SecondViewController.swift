//
//  SecondViewController.swift
//  Login
//
//  Created by Michael Tseitlin on 4/24/19.
//  Copyright © 2019 Michael Tseitlin. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    private var message = ""
    
    @IBOutlet var mainMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainMessage.text = message
    }
}
