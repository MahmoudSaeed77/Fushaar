//
//  AdViewController.swift
//  Fushar
//
//  Created by Mohamed Ibrahem on 2/2/22.
//  Copyright © 2022 Mahmoud Saeed. All rights reserved.
//

import UIKit
import Kingfisher

class AdViewController: UIViewController {

    var imgUrl: String?
    var target: String?
    
    var target2: String?
    
    var counter = 5
        var timer = Timer()
    var delegate: BackFromAd?
    var flag: Bool = false
    
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var adBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(self.imgUrl ?? "")
        
        adBtn.imageView?.image = adBtn.imageView?.image?.withRenderingMode(.alwaysOriginal)
        
        KingfisherManager.shared.retrieveImage(with: URL(string: self.imgUrl ?? "") as! Resource, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
            self.adBtn.setImage(image, for: .normal)
        })
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    @objc func timerAction() {
        if counter == 0 {
            self.dismiss(animated: false) {
                self.timer.invalidate()
                if self.flag {
                    if self.delegate != nil {
                        self.delegate?.fire()
                    }
                } else {
                    self.openURL(url: self.target2 ?? "")
                }
            }
        } else {
            counter-=1
            countLbl.text = "سيتم التحويل في غضون \(counter) ثانيه"
        }
    }
    @IBAction func dismissAction(_ sender: Any) {
        self.timer.invalidate()
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func adAction(_ sender: Any) {
        self.openURL(url: self.target ?? "")
    }
    
}
