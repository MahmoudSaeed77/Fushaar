//
//  WelcomeViewController.swift
//  Fushar
//
//  Created by Mohamed Ibrahem on 1/13/22.
//  Copyright © 2022 Mahmoud Saeed. All rights reserved.
//

import UIKit
import Alamofire

class WelcomeViewController: UIViewController, LoginDelegate {
    func completeLogin(response: LoginModel) {
        self.nameLbl.text = "\(response.user?.firstname ?? "") \(response.user?.lastname ?? "")"
    }
    
    func failedLogin(error: String) {
        print(error)
    }
    

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var supportBtn: UIButton!
    @IBOutlet weak var editPassBtn: UIButton!
    @IBOutlet weak var promotionBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    
    
    let header: HTTPHeaders = ["Accept":"application/json"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nameLbl.text = ""
        
        profileBtn.layer.borderWidth = 1
        profileBtn.layer.borderColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
        profileBtn.layer.cornerRadius = 10
        profileBtn.clipsToBounds = true
        
        supportBtn.layer.borderWidth = 1
        supportBtn.layer.borderColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
        supportBtn.layer.cornerRadius = 10
        supportBtn.clipsToBounds = true
        
        editPassBtn.layer.borderWidth = 1
        editPassBtn.layer.borderColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
        editPassBtn.layer.cornerRadius = 10
        editPassBtn.clipsToBounds = true
        
        logoutBtn.layer.borderWidth = 1
        logoutBtn.layer.borderColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
        logoutBtn.layer.cornerRadius = 10
        logoutBtn.clipsToBounds = true
        
        promotionBtn.layer.borderWidth = 1
        promotionBtn.layer.borderColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
        promotionBtn.layer.cornerRadius = 10
        promotionBtn.clipsToBounds = true
        
        SignInApiManager.sharedInstance.getUserData(header: header, responseDelegate: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func profileAction(_ sender: Any) {
        self.openURL(url: "https://www.fushaar.net/membership/edit/")
    }
    @IBAction func supportAction(_ sender: Any) {
    }
    @IBAction func editPassAction(_ sender: Any) {
        self.openURL(url: "https://www.fushaar.net/membership/edit/")
    }
    @IBAction func promotionAction(_ sender: Any) {
        self.openURL(url: "http://www.fushaar.net/upgrade")
    }
    @IBAction func logoutAction(_ sender: Any) {
        UserDefaultsManager.sharedInstance.saveUserToken(token: "")
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "openLogin")))
    }
    
}
