//
//  SettingsViewController.swift
//  Fushar
//
//  Created by Mohamed Ibrahem on 1/13/22.
//  Copyright © 2022 Mahmoud Saeed. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var alarmSitch: UISwitch!
    @IBOutlet weak var fusshaarBtn: UIButton!
    @IBOutlet weak var explainBtn: UIButton!
    @IBOutlet weak var supportBtn: UIButton!
    @IBOutlet weak var policyBtn: UIButton!
    @IBOutlet weak var promotionBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
        fusshaarBtn.layer.borderWidth = 1
        fusshaarBtn.layer.borderColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
        fusshaarBtn.layer.cornerRadius = 10
        fusshaarBtn.clipsToBounds = true
        
        explainBtn.layer.borderWidth = 1
        explainBtn.layer.borderColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
        explainBtn.layer.cornerRadius = 10
        explainBtn.clipsToBounds = true
        
        supportBtn.layer.borderWidth = 1
        supportBtn.layer.borderColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
        supportBtn.layer.cornerRadius = 10
        supportBtn.clipsToBounds = true
        
        policyBtn.layer.borderWidth = 1
        policyBtn.layer.borderColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
        policyBtn.layer.cornerRadius = 10
        policyBtn.clipsToBounds = true
        
        promotionBtn.layer.borderWidth = 1
        promotionBtn.layer.borderColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
        promotionBtn.layer.cornerRadius = 10
        promotionBtn.clipsToBounds = true
    }

    @IBAction func alarmSwitchAction(_ sender: Any) {
    }
    @IBAction func fushaarAction(_ sender: Any) {
    }
    @IBAction func explainAction(_ sender: Any) {
    }
    @IBAction func supportAction(_ sender: Any) {
    }
    @IBAction func policyAction(_ sender: Any) {
        self.openURL(url: "https://www.fushaar.com/privacy/")
    }
    @IBAction func promotionAction(_ sender: Any) {
        self.openURL(url: "http://www.fushaar.net/upgrade")
    }
    
    
}
