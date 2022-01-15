//
//  DepartmentsViewController.swift
//  Fushar
//
//  Created by Mohamed Ibrahem on 1/13/22.
//  Copyright © 2022 Mahmoud Saeed. All rights reserved.
//

import UIKit
import Alamofire
protocol BackBasketDelegate {
    func backActions(flag: Int) // 0 -> track, 1 -> back
}
class DepartmentsViewController: UIViewController, DepartmentsDelegate {
    func completeGetDepartments(response: [Departments]) {
        self.data = response
        self.collectionView.reloadData()
    }
    
    func failedGetDepartments(error: String) {
        print(error)
    }
    

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var delegate: BackBasketDelegate? = nil
    
    let header: HTTPHeaders = ["Accept":"application/json"]
    var data = [Departments]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        DetailsApiManager.sharedInstance.getAllDepartments(header: header, responseDelegate: self)
        
    }
    

}

extension DepartmentsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - 20, height: 30)
    }
}
extension DepartmentsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        FilmId.catId = self.data[indexPath.item].id ?? 0
        self.dismiss(animated: true) {
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "searchDepartment")))
        }
    }
}
extension DepartmentsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DepartmentCell", for: indexPath) as! DepartmentCell
        cell.nameLbl.text = self.data[indexPath.item].name
        return cell
    }
    
    
}

class DepartmentCell: UICollectionViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
