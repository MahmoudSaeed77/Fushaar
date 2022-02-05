//
//  DownloadViewController.swift
//  Fushar
//
//  Created by Mohamed Ibrahem on 2/2/22.
//  Copyright © 2022 Mahmoud Saeed. All rights reserved.
//

import UIKit

protocol BackFromAd {
    func fire()
}

class DownloadViewController: UIViewController, BackFromAd {
    func fire() {
        if index == 1 {
            self.openURL(url: upUrl ?? "")
        } else if index == 2 {
            self.openURL(url: yandexUrl ?? "")
        } else if index == 3 {
            self.openURL(url: cloudUrl ?? "")
        }
    }
    

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var upBtn: UIButton!
    @IBOutlet weak var yandexBtn: UIButton!
    @IBOutlet weak var cloudBtn: UIButton!
    
    var upUrl: String?
    var yandexUrl: String?
    var cloudUrl: String?
    
    var adUrl: String?
    var imgUrl: String?
    
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        containerView.layer.cornerRadius = 51
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        upBtn.layer.borderWidth = 1
        upBtn.layer.borderColor = UIColor.darkGray.cgColor
        
        yandexBtn.layer.borderWidth = 1
        yandexBtn.layer.borderColor = UIColor.darkGray.cgColor
        
        cloudBtn.layer.borderWidth = 1
        cloudBtn.layer.borderColor = UIColor.darkGray.cgColor
        
        
    }
    @IBAction func upAction(_ sender: Any) {
        showAd()
        index = 1
    }
    @IBAction func yandexAction(_ sender: Any) {
        showAd()
        index = 2
    }
    @IBAction func cloudAction(_ sender: Any) {
        showAd()
        index = 3
    }
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showAd() {
        let vc = storyboard?.instantiateViewController(identifier: "AdViewController") as! AdViewController
        vc.flag = true
        vc.delegate = self
        vc.imgUrl = imgUrl ?? ""
        vc.target = adUrl ?? ""
        self.present(vc, animated: false, completion: nil)
    }
}
