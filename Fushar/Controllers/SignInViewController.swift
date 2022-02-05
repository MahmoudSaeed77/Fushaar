//
//  SignInViewController.swift
//  Fushar
//
//  Created by Mohamed Ibrahem on 1/13/22.
//  Copyright © 2022 Mahmoud Saeed. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, LoginDelegate {
    func completeLogin(response: LoginModel) {
        UserDefaultsManager.sharedInstance.saveUserToken(token: response.cookie ?? "")
//        self.allerMessage(title: "", message: "successfull")
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "openProfile")))
    }
    
    func failedLogin(error: String) {
        self.allertError(title: "", message: error)
    }
    

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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailField.text = ""
        passField.text = ""
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
        self.openURL(url: "http://www.fushaar.net/upgrade")
    }
    @IBAction func loginAction(_ sender: Any) {
        SignInApiManager.sharedInstance.login(email: self.emailField.text ?? "", pass: self.passField.text ?? "", responseDelegate: self)
    }
    @IBAction func save2Action(_ sender: Any) {
        self.openURL(url: "http://www.fushaar.net/upgrade")
    }
    @IBAction func forgotAction(_ sender: Any) {
        self.openURL(url: "https://www.fushaar.net/membership/edit/")
    }
}
