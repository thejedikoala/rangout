//
//  SignInVC.swift
//  Rangout for Buyer
//
//  Created by Eiji Kawahira on 22/11/16.
//  Copyright © 2016 Eiji Kawahira. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logIn(_ sender: AnyObject) {
    
        if emailTextField.text != "" && passwordTextField.text != "" {
            
        }
        
    }
    
    @IBAction func signUp(_ sender: AnyObject) {
    }

} // class




