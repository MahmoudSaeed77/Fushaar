//
//  ContainerViewController.swift
//  IDC
//
//  Created by apple on 10/6/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    //Manipulating container views
    fileprivate weak var viewController : UIViewController!
    //Keeping track of containerViews
    fileprivate var containerViewObjects = Dictionary<String,UIViewController>()
    // Pass in a tuple of required TimeInterval with UIViewAnimationOptions
    var animationDurationWithOptions:(TimeInterval, UIView.AnimationOptions) = (0,[])
    
    // Specifies which ever container view is on the front
    open var currentViewController : UIViewController{
        get {
            return self.viewController
            
        }
    }
    
    
    fileprivate var segueIdentifier : String!
    
    //Identifier For First Container SubView
    @IBInspectable internal var firstLinkedSubView : String!
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
    }
    open override func viewDidAppear(_ animated: Bool) {
        if let identifier = firstLinkedSubView{
            segueIdentifierReceivedFromParent(identifier)
        }
    }
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func segueIdentifierReceivedFromParent(_ identifier: String){
        
        self.segueIdentifier = identifier
        self.performSegue(withIdentifier: self.segueIdentifier, sender: nil)
        
    }
    
    
    
    
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier{
            //Remove Container View
            if viewController != nil{
                viewController.view.removeFromSuperview()
                viewController = nil
                
            }
            
//            if segue.identifier == "details" {
//                // Do stuff...
//                let vc = storyboard?.instantiateViewController(withIdentifier: "ProjectDetailsViewController") as! ProjectDetailsViewController
//                navigationController?.pushViewController(vc, animated: true)
//            }
            
            //Add to dictionary if isn't already there
            if ((self.containerViewObjects[self.segueIdentifier] == nil)){
                viewController = segue.destination
                self.containerViewObjects[self.segueIdentifier] = viewController
                
            }else{
                for (key, value) in self.containerViewObjects{
                    
                    if key == self.segueIdentifier{
                        viewController = value
                    }
                }
                
            }
            UIView.transition(with: self.view, duration: animationDurationWithOptions.0, options: animationDurationWithOptions.1, animations: {
                self.addChild(self.viewController)
                self.viewController.view.frame = CGRect(x: 0,y: 0, width: self.view.frame.width,height: self.view.frame.height)
                self.view.addSubview(self.viewController.view)
            }, completion: { (complete) in
                self.viewController.didMove(toParent: self)
            })
            
            
            
        }
        
    }
}

class Empty: UIStoryboardSegue {
    
    override func perform() {
        
    }
    
}


class ViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    var container: ContainerViewController!
    
    var selected: Int?
    
    let images = [#imageLiteral(resourceName: "setting-2"), #imageLiteral(resourceName: "profile-circle"), #imageLiteral(resourceName: "home"), #imageLiteral(resourceName: "menu")]
    var backFrom: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        selected = 2
        
        bottomView.layer.cornerRadius = 21
        bottomView.clipsToBounds = true
        
        
        container!.segueIdentifierReceivedFromParent("home")
        
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        navigationController?.navigationBar.isHidden = true
        for img in images {
            img.withRenderingMode(.alwaysTemplate)
        }
        
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "container" {
            container = segue.destination as? ContainerViewController
            //For adding animation to the transition of containerviews you can use container's object property
            // animationDurationWithOptions and pass in the time duration and transition animation option as a tuple
            // Animations that can be used
            // .transitionFlipFromLeft, .transitionFlipFromRight, .transitionCurlUp
            // .transitionCurlDown, .transitionCrossDissolve, .transitionFlipFromTop
            container.animationDurationWithOptions = (0.2, .curveEaseInOut)
        }
    }
    
    
    @IBAction func backAction(_ sender: Any) {
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 4, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selected = indexPath.item
        switch indexPath.item {
        case 0:
            container!.segueIdentifierReceivedFromParent("settingsNav")
            print(0)
        case 1:
            container!.segueIdentifierReceivedFromParent("profileNav")
            print(1)
        case 2:
            container!.segueIdentifierReceivedFromParent("home")
            print(2)
        case 3:
//            container!.segueIdentifierReceivedFromParent("menu")
            let vc = storyboard?.instantiateViewController(identifier: "DepartmentsViewController") as! DepartmentsViewController
            self.present(vc, animated: true) {
                
            }
            print(3)
        default:
            break
        }
        collectionView.reloadData()
    }
}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BarCell", for: indexPath) as! BarCell
        
        cell.containerView.layer.cornerRadius = 21
        cell.clipsToBounds = true
        
        cell.iconView.image = images[indexPath.item]
        print(selected ?? -200)
        
        if indexPath.item == selected {
            cell.containerView.backgroundColor = #colorLiteral(red: 0.5568627451, green: 0.462745098, blue: 0.3176470588, alpha: 0.68)
        } else {
            cell.containerView.backgroundColor = UIColor.clear
        }
        
        return cell
    }
}
class BarCell: UICollectionViewCell {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
