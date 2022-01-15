//
//  SignInViewController.swift
//  Fushar
//
//  Created by Mohamed Ibrahem on 1/13/22.
//  Copyright © 2022 Mahmoud Saeed. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UI()
    }
    fileprivate func UI() {
        self.navigationController?.navigationBar.isHidden = true
        containerView.layer.cornerRadius = 37
        containerView.clipsToBounds = true
        
        saveBtn.layer.cornerRadius = 10
        saveBtn.clipsToBounds = true
        
        emailField.layer.cornerRadius = 8
        emailField.clipsToBounds = true
        
        passField.layer.cornerRadius = 8
        passField.clipsToBounds = true
        
        loginBtn.layer.cornerRadius = 8
        loginBtn.clipsToBounds = true
        
        
    }
    @IBAction func saveAction(_ sender: Any) {
    }
    @IBAction func loginAction(_ sender: Any) {
    }
    @IBAction func save2Action(_ sender: Any) {
    }
    @IBAction func forgotAction(_ sender: Any) {
    }
}
