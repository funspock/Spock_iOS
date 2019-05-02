//
//  ViewController.swift
//  Spock
//
//  Created by 相川健太 on 2019/05/01.
//  Copyright © 2019 相川健太. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        let userName = userNameField.text
        let password = passwordField.text
        print(userName)
        print(password)
    }
}

