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
class DepartmentsViewController: UIViewController, DepartmentsDelegate, UITextFieldDelegate {
    func completeGetDepartments(response: [Departments]) {
        self.filteredArray = response
        self.data = response
        self.collectionView.reloadData()
    }
    
    func failedGetDepartments(error: String) {
        print(error)
    }
    

    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var delegate: BackBasketDelegate? = nil
    
    let header: HTTPHeaders = ["Accept":"application/json"]
    var data = [Departments]()
    var filteredArray = [Departments]()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .clear
        containerView.backgroundColor = .clear
        
        
        blurView.layer.cornerRadius = 51
        blurView.clipsToBounds = true
        blurView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchField.layer.borderColor = UIColor.white.cgColor
        searchField.layer.borderWidth = 1
        searchField.layer.cornerRadius = 8
        searchField.clipsToBounds = true
        searchField.placeholder = "البحث هنا..."
        searchField.textAlignment = .right
        
        DetailsApiManager.sharedInstance.getAllDepartments(header: header, responseDelegate: self)
        
        searchField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        searchField.delegate = self
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            // TODO: Do your stuff here.
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "selectSelected")))
        }
    }
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func textFieldDidChange(textField: UITextField) {
        filteredArray.removeAll()
        if textField.text == "" {
            filteredArray = data
        } else {
            for name in data {
                if name.name?.contains(textField.text ?? "") ?? Bool() {
                    filteredArray.append(name)
                }
            }
        }
        collectionView.reloadData()
    }
    

}

extension DepartmentsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - 10, height: 40)
    }
}
extension DepartmentsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        FilmId.catId = self.filteredArray[indexPath.item].id ?? 0
        self.dismiss(animated: true) {
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "searchDepartment")))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
extension DepartmentsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filteredArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DepartmentCell", for: indexPath) as! DepartmentCell
        cell.nameLbl.text = self.filteredArray[indexPath.item].name
        cell.layer.cornerRadius = 4
        cell.clipsToBounds = true
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
    
    
}

class DepartmentCell: UICollectionViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
