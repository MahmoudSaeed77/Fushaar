//
//  HomeViewController.swift
//  Fushar
//
//  Created by Mohamed Ibrahem on 1/12/22.
//  Copyright © 2022 Mahmoud Saeed. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class HomeViewController: UIViewController, FilmsDelegate {
    
    func completeGetFilms(response: [Movies]) {
        self.data = response
        self.collectionView.reloadData()
        refresh.endRefreshing()
    }
    
    func failedGetFilms(error: String) {
        print(error)
//        DetailsApiManager.sharedInstance.getAllFilms(header: header, responseDelegate: self)
    }
    

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data = [Movies]()
    var refresh = UIRefreshControl()
    let header: HTTPHeaders = ["Accept":"application/json"]
    var delegate: BackBasketDelegate? = nil
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "searchDepartment"), object: nil, queue: nil) {_ in
            // do network here
            DetailsApiManager.sharedInstance.getDepartmentMovies(header: self.header, id: FilmId.catId ?? 0, responseDelegate: self)
        }
        
        self.navigationController?.navigationBar.isHidden = true
        nameLbl.text = ""
        scrollView.refreshControl = refresh
        refresh.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        
        setupCollection()
        
        DetailsApiManager.sharedInstance.getAllFilms(header: header, responseDelegate: self)
    }
    
    fileprivate func setupCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @IBAction func searchAction(_ sender: Any) {
        print("search work")
    }
    @IBAction func watchAction(_ sender: Any) {
        print("watch work")
    }
    @IBAction func downloadAction(_ sender: Any) {
        print("download work")
    }
    
    
    @objc func moreAction(sender: UIButton) {
        let index = sender.tag
        print(index)
        FilmId.id = self.data[index].id ?? 0
        let vc = storyboard?.instantiateViewController(withIdentifier: "nav") as! UINavigationController
        self.navigationController?.present(vc, animated: false, completion: nil)
    }
    
    @objc func refreshAction() {
        DetailsApiManager.sharedInstance.getAllFilms(header: header, responseDelegate: self)
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 3) - 2, height: 200)
    }
}
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.id = self.data[indexPath.item].id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        cell.imgView.kf.setImage(with: URL(string: self.data[indexPath.item].img1 ?? ""))
        cell.rateLbl.text = self.data[indexPath.item].rate ?? ""
        
        cell.moreBtn.tag = indexPath.item
        cell.moreBtn.addTarget(self, action: #selector(moreAction), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
}
