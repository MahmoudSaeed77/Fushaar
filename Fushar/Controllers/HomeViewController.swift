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
import ViewAnimator

class HomeViewController: UIViewController, FilmsDelegate, BannerDelegate, DepartmentsDelegate, UIPopoverPresentationControllerDelegate, LoginDelegate, UIViewControllerTransitioningDelegate, AdsDelegate {
    func completeGetAds(response: [AdsModel]) {
        self.ads = response
    }
    
    func failedGetAds(error: String) {
        print(error)
    }
    
    func completeLogin(response: LoginModel) {
        self.nameLbl.text = "\(response.user?.firstname ?? "") \(response.user?.lastname ?? "")"
    }
    
    func failedLogin(error: String) {
        print(error)
    }
    
    func completeGetBanner(response: [BannerModel]) {
        self.banner = response
        self.pageController.numberOfPages = response.count
        self.pageController.reloadInputViews()
        self.bannerCollectionView.reloadData()
    }
    
    func failedGetBanner(error: String) {
        print(error)
    }
    
    
    func completeGetFilms(response: [Movies]) {
        self.data+=response
        self.homeCollectionView.reloadData()
        refresh.endRefreshing()
        print(((response.count / 3) * 200) + 200)
        heightconstraint.constant = CGFloat(((data.count / 3) * 200) + (10*(data.count/3)))
    }
    
    func failedGetFilms(error: String) {
        print(error)
    }
    
    func completeGetDepartments(response: [Departments]) {
        self.filteredArray = response
        self.listCollectionView.reloadData()
    }
    
    func failedGetDepartments(error: String) {
        print(error)
    }
    

    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    @IBOutlet weak var heightconstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    
    var data = [Movies]()
    var banner = [BannerModel]()
    var filteredArray = [Departments]()
    var ads = [AdsModel]()
    var refresh = UIRefreshControl()
    let header: HTTPHeaders = ["Accept":"application/json"]
    var delegate: BackBasketDelegate? = nil
    var currentIndex: Int?
    
    var width: CGFloat?
    var height: CGFloat?
    
    var pageIndex: Int = 1
    
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        for view in self.view.subviews as [UIView] {
//            if view == UICollectionView() {
//                view.showLoader()
//            }
//        }
        
        
        scrollView.delegate = self
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            // It's an iPhone
            homeCollectionView.isScrollEnabled = false
            scrollView.isScrollEnabled = true
            width = (view.frame.width / 3) - 11
            height = 200.0
        case .pad:
            // It's an iPad (or macOS Catalyst)
            homeCollectionView.isScrollEnabled = true
            scrollView.isScrollEnabled = false
            width = 140.0
            height = 210.0
         @unknown default:
            // Uh, oh! What could it be?
            print("unknown device")
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "searchDepartment"), object: nil, queue: nil) {_ in
            // do network here
            self.data.removeAll()
            DetailsApiManager.sharedInstance.getDepartmentMovies(header: self.header, id: FilmId.catId ?? 0, responseDelegate: self)
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "openDetails"), object: nil, queue: nil) {_ in
            // go to details
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
            vc.id = FilmId.id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        self.navigationController?.navigationBar.isHidden = true
        nameLbl.text = ""
        scrollView.refreshControl = refresh
        refresh.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        refresh.tintColor = UIColor.white
        
        setupCollection()
        
        SignInApiManager.sharedInstance.getUserData(header: header, responseDelegate: self)
        DetailsApiManager.sharedInstance.getAllFilms(pageNum: pageIndex, header: header, responseDelegate: self)
        DetailsApiManager.sharedInstance.getBanners(header: header, responseDelegate: self)
        DetailsApiManager.sharedInstance.getAds(header: header, responseDelegate: self)
        DetailsApiManager.sharedInstance.getAllDepartments(header: header, responseDelegate: self)
        
        
        
        
        

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewWillAppear")
        SignInApiManager.sharedInstance.getUserData(header: header, responseDelegate: self)
        UserDefaults.standard.synchronize()
        if UserDefaultsManager.sharedInstance.getUserToken() == "" {
            logoImgView.isHidden = false
            nameLbl.isHidden = true
        } else {
            logoImgView.isHidden = true
            nameLbl.isHidden = false
        }
    }
    
    

    
    fileprivate func setupCollection() {
        bannerCollectionView.isPagingEnabled = true
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
    }
    
    @IBAction func searchAction(_ sender: Any) {
        print("search work")
    }
    @IBAction func watchAction(_ sender: Any) {
        print("watch work")
        self.openURL(url: self.banner[1].targeturl ?? "")
    }
    @IBAction func downloadAction(_ sender: Any) {
        print("download work")
        self.openURL(url: self.banner[2].targeturl ?? "")
    }
    
    
    @objc func moreAction(sender: UIButton) {
        let index = sender.tag
        print(index)
        let vc = storyboard?.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        FilmId.id = self.data[index].id ?? 0
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            // It's an iPhone
            self.present(vc, animated: true, completion: nil)
        case .pad:
            // It's an iPad (or macOS Catalyst)
            vc.modalPresentationStyle = .popover
            vc.preferredContentSize = CGSize(width: 389, height: 381)
            let pVC = vc.popoverPresentationController
            pVC?.permittedArrowDirections = .any
            pVC?.delegate = self
            pVC?.sourceView = sender
            pVC?.sourceRect = CGRect(x: 0, y: 0, width: 1, height: 1)
            present(vc, animated: true, completion: nil)
         @unknown default:
            // Uh, oh! What could it be?
            print("unknown device")
        }
        
        
    }
    
    @objc func refreshAction() {
        SignInApiManager.sharedInstance.getUserData(header: header, responseDelegate: self)
        DetailsApiManager.sharedInstance.getAllFilms(pageNum: pageIndex, header: header, responseDelegate: self)
        DetailsApiManager.sharedInstance.getBanners(header: header, responseDelegate: self)
    }
    
    @objc func nextIndexAction() {
//        bannerCollectionView.scrollToItem(at: IndexPath(item: self.currentIndex ?? 0 + 1, section: 0), at: .right, animated: true)
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == bannerCollectionView {
            return 0
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == homeCollectionView {
            return 10
        }
        return CGFloat()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bannerCollectionView {
            return CGSize(width: (bannerCollectionView.frame.width), height: bannerCollectionView.frame.height)
        } else if collectionView == listCollectionView {
            return CGSize(width: collectionView.frame.width, height: 40)
        } else {
            return CGSize(width: self.width ?? 0.0, height: self.height ?? 0.0)
        }
    }
}
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        if collectionView == bannerCollectionView {
            print("banner here...")
            print(self.banner[indexPath.item].targeturl ?? "")
            
            let vc = storyboard?.instantiateViewController(identifier: "AdViewController") as! AdViewController
            vc.target2 = self.banner[indexPath.item].targeturl ?? ""
            vc.target = self.ads[indexPath.item].targeturl ?? ""
            vc.imgUrl = self.ads[indexPath.item].imgurl ?? ""
            self.present(vc, animated: false, completion: nil)
        } else if collectionView == listCollectionView {
            print("list is here")
            FilmId.catId = self.filteredArray[indexPath.item].id ?? 0
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "searchDepartment")))
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
            vc.id = self.data[indexPath.item].id ?? 0
            vc.beforeDownloadUrl = self.ads[2].targeturl ?? ""
            vc.beforeWatchUrl = self.ads[3].targeturl ?? ""
            vc.imgUrl = self.ads[2].imgurl ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension HomeViewController: UICollectionViewDataSource, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        switch collectionView {
        case bannerCollectionView:
            self.currentIndex = indexPath.item
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
//            let processor = RoundCornerImageProcessor(cornerRadius: 20)
//            cell.imgView.kf.indicatorType = .activity
//            cell.imgView.kf.indicator?.startAnimatingView()
            cell.imgView.kf.setImage(with: URL(string: self.banner[indexPath.item].imgurl ?? "")/*, options: [.processor(processor), .transition(.fade(0.2))]*/)
            
//            let t = Timer(timeInterval: Double(self.banner[indexPath.item].timer ?? "") ?? 0.0, target: self, selector: #selector(nextIndexAction), userInfo: nil, repeats: false)
//            t.fire()
            return cell
        case homeCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
            cell.indicator.isHidden = false
            cell.indicator.startAnimating()
            cell.imgView.kf.setImage(with: URL(string: self.data[indexPath.item].img1 ?? ""), placeholder: nil, options: nil, progressBlock: nil) { (img, err, type, url) in
                cell.indicator.stopAnimating()
            }
            cell.rateLbl.text = self.data[indexPath.item].rate ?? ""
            cell.moreBtn.tag = indexPath.item
            cell.moreBtn.addTarget(self, action: #selector(moreAction), for: .touchUpInside)
            let animation = AnimationType.from(direction: .left, offset: 30.0)
            cell.animate(animations: [animation], duration: 0.5)
            return cell
        case listCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DepartmentCell", for: indexPath) as! DepartmentCell
            cell.nameLbl.text = self.filteredArray[indexPath.item].name
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 1
            return cell
        default:
            break;
        }
        
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bannerCollectionView {
            return self.banner.count
        } else if collectionView == listCollectionView {
            return self.filteredArray.count
        } else {
            return self.data.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageController.currentPage = indexPath.item
        
    }
    
    var isLastCellVisible: Bool {
        let lastIndexPath = NSIndexPath(item: self.data.count - 1, section: 0)
        var cellFrame = self.homeCollectionView.layoutAttributesForItem(at: lastIndexPath as IndexPath)!.frame

        cellFrame.size.height = cellFrame.size.height

        var cellRect = self.homeCollectionView.convert(cellFrame, to: self.homeCollectionView.superview)

        cellRect.origin.y = cellRect.origin.y - cellFrame.size.height - 100
        // substract 100 to make the "visible" area of a cell bigger

        var visibleRect = CGRect(
            x: self.homeCollectionView.bounds.origin.x,
            y: self.homeCollectionView.bounds.origin.y,
            width: self.homeCollectionView.bounds.size.width,
            height: self.homeCollectionView.bounds.size.height - self.homeCollectionView.contentInset.bottom
        )

        visibleRect = self.homeCollectionView.convert(visibleRect, to: self.homeCollectionView.superview)

        if visibleRect.contains(cellRect) {
            return true
        }

        return false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {    
       let scrollViewHeight = scrollView.frame.size.height
        let scrollContentSizeHeight = scrollView.contentSize.height
         let scrollOffset = scrollView.contentOffset.y

        if (scrollOffset == 0)
        {
            // then we are at the top
            print("then we are at the top")
        }
        else if (scrollOffset + scrollViewHeight == scrollContentSizeHeight)
        {
            if !data.isEmpty {
                print("then we are at the end")
                // then we are at the end
                self.pageIndex+=1
                DetailsApiManager.sharedInstance.getAllFilms(pageNum: self.pageIndex, header: self.header, responseDelegate: self)
            }
        }
    }
    
}
