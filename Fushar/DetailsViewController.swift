//
//  DetailsViewController.swift
//  Fushar
//
//  Created by Mohamed Ibrahem on 1/12/22.
//  Copyright © 2022 Mahmoud Saeed. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import AVKit
import AVFoundation

class DetailsViewController: UIViewController, DetailsDelegate {
    func completeGetFilm(response: Welcome) {
        self.data = response!
        print(response?.first?.poster ?? "")
        self.imgView.kf.setImage(with: URL(string: response?.first?.poster ?? ""))
        self.arNameLbl.text = response?.first?.arabicname ?? ""
        self.enNameLbl.text = response?.first?.title ?? ""
        self.rateLbl.text = response?.first?.rate ?? ""
        self.yearLbl.text = response?.first?.year ?? ""
        self.countLbl.text = response?.first?.parent ?? ""
        self.typeLbl.text = response?.first?.gerne ?? ""
        self.desTextView.setHTMLFromString(text: response?.first?.content ?? "")
        self.urlString = response?.first?.fushaar480 ?? ""
        self.actorsLbl.text = response?.first?.qlyt ?? ""
        self.desTextView.textColor = UIColor.white
        self.desTextView.textAlignment = .right
        refresh.endRefreshing()
    }
    
    func failedGetFilm(error: String) {
        print(error)
//        netWork()
    }
    

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var enNameLbl: UILabel!
    @IBOutlet weak var arNameLbl: UILabel!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var watchBtn: UIButton!
    @IBOutlet weak var downloadBtn: UIButton!
    @IBOutlet weak var desTextView: UITextView!
    @IBOutlet weak var adBtn: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var actorsLbl: UILabel!
    @IBOutlet weak var shadowView: GradientView!
    
    var aboutArr = ["أكشن", "إثارة", "غموض"]
    
    var id: Int?
    var urlString: String?
    var data = [MovieDetailsModel]()
    var refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UI()
        netWork()
    }
    fileprivate func UI() {
        scrollView.refreshControl = refresh
        refresh.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        
        shareView.layer.cornerRadius = 9
        shareView.clipsToBounds = true
        backView.layer.cornerRadius = 9
        backView.clipsToBounds = true
        rateLbl.layer.cornerRadius = 9
        rateLbl.clipsToBounds = true
        
        countLbl.layer.cornerRadius = 8
        countLbl.clipsToBounds = true
        
        typeLbl.layer.cornerRadius = 8
        typeLbl.clipsToBounds = true
        
        yearLbl.layer.cornerRadius = 8
        yearLbl.clipsToBounds = true
        
        watchBtn.layer.cornerRadius = 20
        watchBtn.clipsToBounds = true
        
        downloadBtn.layer.cornerRadius = 20
        downloadBtn.clipsToBounds = true
        
        adBtn.layer.cornerRadius = 10
        adBtn.clipsToBounds = true
        
        containerView.layer.cornerRadius = 55
        containerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        
        downloadBtn.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        watchBtn.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
        
        self.arNameLbl.text = ""
        self.enNameLbl.text = ""
        self.rateLbl.text = ""
        self.yearLbl.text = ""
        self.countLbl.text = ""
        self.typeLbl.text = ""
        self.desTextView.text = ""
        self.actorsLbl.text = ""
        self.desTextView.textColor = UIColor.white
        self.desTextView.textAlignment = .right
    }
    
    fileprivate func netWork() {
        let header: HTTPHeaders = ["Accept":"application/json"]
        DetailsApiManager.sharedInstance.getFilmDetails(header: header, id: "\(self.id ?? 0)", responseDelegate: self)
    }
    
    @IBAction func shareAction(_ sender: Any) {
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func shahedAction(_ sender: Any) {
        openURL(url: "")
    }
    @IBAction func watchAction(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "اختر الجودة", message: "", preferredStyle: .actionSheet)
        
        let g240 = UIAlertAction(title: "240p", style: .default) { (action) in
            let url = URL(string: self.data.first?.fushaar240 ?? "")!
            self.playVideo(url: url)
        }
        
        let g480 = UIAlertAction(title: "480p", style: .default) { (action) in
            let url = URL(string: self.data.first?.fushaar480 ?? "")!
            self.playVideo(url: url)
        }
        
        let g1080 = UIAlertAction(title: "1080p", style: .default) { (action) in
            let url = URL(string: self.data.first?.fushaar1080 ?? "")!
            self.playVideo(url: url)
        }
        
        alert.addAction(g240)
        alert.addAction(g480)
        alert.addAction(g1080)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        self.navigationController?.present(alert, animated: true, completion: nil)
        
        
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view //to set the source of your alert
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
            popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
        }
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBAction func downloadAction(_ sender: Any) {
        let alert = UIAlertController(title: "اختر السيرفر", message: "", preferredStyle: .actionSheet)
        
        let UpToBox = UIAlertAction(title: "UpToBox", style: .default) { (action) in
            self.openURL(url: self.data.first?.uptobox ?? "")
        }
        
        let Yandex = UIAlertAction(title: "Yandex", style: .default) { (action) in
            self.openURL(url: self.data.first?.yandex ?? "")
        }
        
        let Cloud_240 = UIAlertAction(title: "Cloud 240", style: .default) { (action) in
            self.openURL(url: self.data.first?.cloud240 ?? "")
        }
        
        let Cloud_480 = UIAlertAction(title: "Cloud 480", style: .default) { (action) in
            self.openURL(url: self.data.first?.cloud480 ?? "")
        }
        
        let Cloud_1080 = UIAlertAction(title: "Cloud 1080", style: .default) { (action) in
            self.openURL(url: self.data.first?.cloud1080 ?? "")
        }
        
        alert.addAction(UpToBox)
        alert.addAction(Yandex)
        alert.addAction(Cloud_240)
        alert.addAction(Cloud_480)
        alert.addAction(Cloud_1080)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        self.navigationController?.present(alert, animated: true, completion: nil)
        
        
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view //to set the source of your alert
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
            popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
        }
        self.present(alert, animated: true, completion: nil)

    }
    @IBAction func adAction(_ sender: Any) {
        
        let youtubeId = self.data.first?.trailer ?? ""
        var youtubeUrl = NSURL(string:"youtube://\(youtubeId)")!
        if UIApplication.shared.canOpenURL(youtubeUrl as URL){
            UIApplication.shared.openURL(youtubeUrl as URL)
        } else{
                youtubeUrl = NSURL(string:"https://www.youtube.com/watch?v=\(youtubeId)")!
            UIApplication.shared.openURL(youtubeUrl as URL)
        }
        
    }
    func playVideo(url: URL) {
        let player = AVPlayer(url: url)
        
        let vc = AVPlayerViewController()
        vc.player = player
        
        self.present(vc, animated: true) { vc.player?.play() }
    }
    
    @objc func refreshAction() {
        netWork()
    }
}
