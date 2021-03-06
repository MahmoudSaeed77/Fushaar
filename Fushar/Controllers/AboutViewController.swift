//
//  AboutViewController.swift
//  Fushar
//
//  Created by Mohamed Ibrahem on 1/12/22.
//  Copyright © 2022 Mahmoud Saeed. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class AboutViewController: UIViewController, DetailsDelegate {

    func completeGetFilm(response: Welcome) {
        self.imgView.kf.setImage(with: URL(string: response?.first?.poster ?? ""))
        self.arNAmeLbl.text = response?.first?.arabicname ?? ""
        self.enNameLBl.text = response?.first?.title ?? ""
        self.rateLBl.text = response?.first?.rate ?? ""
        self.yearLbl.text = response?.first?.year ?? ""
        self.countLbl.text = response?.first?.parent ?? ""
        self.timeLbl.text = response?.first?.duration ?? ""
        self.typeLbl.text = response?.first?.gerne ?? ""
        self.desTextView.setHTMLFromString(text: response?.first?.content ?? "")
        
        self.desTextView.textAlignment = .right
        UIView.animate(withDuration: 1) {
            self.loaderView.alpha = 0
            self.indicator.alpha = 0
            self.indicator.isHidden = true
            self.loaderView.isHidden = true
        }
        
    }
    
    func failedGetFilm(error: String) {
        print(error)
    }
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var enNameLBl: UILabel!
    @IBOutlet weak var arNAmeLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var rateLBl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var desTextView: UITextView!
    @IBOutlet weak var showBtn: UIButton!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UI()
        netWork()
    }
    fileprivate func UI() {
        
        
        
        self.navigationController?.navigationBar.isHidden = true
        containerView.layer.cornerRadius = 51
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        loaderView.layer.cornerRadius = 51
        rateLBl.layer.cornerRadius = 5
        rateLBl.clipsToBounds = true
        
        showBtn.layer.cornerRadius = 9
        showBtn.clipsToBounds = true
        
        self.arNAmeLbl.text = ""
        self.enNameLBl.text = ""
        self.rateLBl.text = ""
        self.yearLbl.text = ""
        self.countLbl.text = ""
        self.typeLbl.text = ""
        self.desTextView.text = ""
        self.desTextView.textAlignment = .right
        
        imgView.dropShadowView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        indicator.startAnimating()
    }
    
    fileprivate func netWork() {
        print(FilmId.id ?? 0)
        
        let header: HTTPHeaders = ["Accept":"application/json"]
        DetailsApiManager.sharedInstance.getFilmDetails(header: header, id: "\(FilmId.id ?? 0)", responseDelegate: self)
        
    }
    
    @IBAction func showAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.id = FilmId.id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
        
        self.dismiss(animated: true) {
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "openDetails")))
        }
    }
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
