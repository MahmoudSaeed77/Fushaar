//
//  Extensions.swift
//  khuzama
//
//  Created by apple on 9/20/20.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation
import UIKit
//import MOLH

extension UIView {
    
    func dropShadow() {
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .zero
        layer.shadowRadius = 3
    }
    
    func dropShadowView() {
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 3
        layer.masksToBounds = false
    }
    
}

extension String {
    public var arToEnDigits : String {
        let arabicNumbers = ["٠": "0","١": "1","٢": "2","٣": "3","٤": "4","٥": "5","٦": "6","٧": "7","٨": "8","٩": "9"]
        var txt = self
        arabicNumbers.map { txt = txt.replacingOccurrences(of: $0, with: $1)}
        return txt
    }
}

@IBDesignable
class GradientBtn: UIButton {
    @IBInspectable var startColor: UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor:  UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double = 0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation: Double = 0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode: Bool = false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode: Bool = false { didSet { updatePoints() }}
    override public class var layerClass: AnyClass { return CAGradientLayer.self }
    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0, y: 0)
            gradientLayer.endPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 1, y: 0)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0, y: 0)
            gradientLayer.endPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 1, y: 0)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}

@IBDesignable
class GradientView: UIView {
    @IBInspectable var startColor: UIColor = .white { didSet { updateColors() }}
    @IBInspectable var endColor:  UIColor = .black { didSet { updateColors() }}
    @IBInspectable var startLocation: Double = 0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation: Double = 0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode: Bool = false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode: Bool = false { didSet { updatePoints() }}
    override public class var layerClass: AnyClass { return CAGradientLayer.self }
    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0, y: 0)
            gradientLayer.endPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 1, y: 0)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0, y: 0)
            gradientLayer.endPoint = diagonalMode ? .init(x: 0, y: 1) : .init(x: 0, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}

extension UIViewController {
    
    
    func allertError(title:String, message:String){
        let alert = UIAlertController(title: title, message:message , preferredStyle: UIAlertController.Style.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "ok".localized, style: UIAlertAction.Style.default, handler: { action in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func allerMessage(title:String, message:String){
        let alert = UIAlertController(title: title, message:message , preferredStyle: UIAlertController.Style.alert)
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "ok".localized, style: UIAlertAction.Style.default, handler: { action in
            //            self.dismiss(animated: true, completion: nil)
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    static func createFromNib<T: UIViewController>(storyBoardId: String) -> T?{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: storyBoardId) as? T
    }
    
    func navigationTitleName(title:String){
        self.navigationItem.title = title
    }
}
extension UIView {
    
    
    func allertError(title:String, message:String){
        let alert = UIAlertController(title: title, message:message , preferredStyle: UIAlertController.Style.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "ok".localized, style: UIAlertAction.Style.default, handler: { action in
            
        }))
        //        self.present(alert, animated: true, completion: nil)
    }
    
    func allerMessage(title:String, message:String){
        let alert = UIAlertController(title: title, message:message , preferredStyle: UIAlertController.Style.alert)
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "ok".localized, style: UIAlertAction.Style.default, handler: { action in
            //            self.dismiss(animated: true, completion: nil)
            alert.dismiss(animated: true, completion: nil)
        }))
        //        self.present(alert, animated: true, completion: nil)
    }
    
    static func createFromNib<T: UIViewController>(storyBoardId: String) -> T?{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: storyBoardId) as? T
    }
    
    func navigationTitleName(title:String){
        //        self.navigationItem.title = title
    }
}
extension String{
    var trimmed:String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var localized:String{
        return NSLocalizedString(self, comment: "")
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
extension UITextView{
    func setHTMLFromString(text: String) {
        let modifiedFont = NSString(format:"<span style=\"font-family: \(self.font!.fontName); font-size: \(14)\">%@</span>" as NSString, text)
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: String.Encoding.unicode.rawValue, allowLossyConversion: true)!,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        self.attributedText = attrStr
    }
}
extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
class RectangularDashedView: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var dashWidth: CGFloat = 0
    @IBInspectable var dashColor: UIColor = .clear
    @IBInspectable var dashLength: CGFloat = 0
    @IBInspectable var betweenDashesSpace: CGFloat = 0
    var dashBorder: CAShapeLayer?
    override func layoutSubviews() {
        super.layoutSubviews()
        dashBorder?.removeFromSuperlayer()
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = dashWidth
        dashBorder.strokeColor = dashColor.cgColor
        dashBorder.lineDashPattern = [dashLength, betweenDashesSpace] as [NSNumber]
        dashBorder.frame = bounds
        dashBorder.fillColor = nil
        if cornerRadius > 0 {
            dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        } else {
            dashBorder.path = UIBezierPath(rect: bounds).cgPath
        }
        layer.addSublayer(dashBorder)
        self.dashBorder = dashBorder
    }
}
extension Date {
    func TotimeStamp() -> Int64 {
        return Int64(self.timeIntervalSince1970)
    }
}

extension Double{
    func convertDate(formate: String, lang:String) -> String{
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current //Set timezone that you want
        dateFormatter.locale = NSLocale(localeIdentifier: lang ) as Locale
        dateFormatter.dateFormat = formate //Specify your format that you want
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}

func checkdate(selected:Date) -> Int {
    let calendar = Calendar.current
    // Replace the hour (time) of both dates with 00:00
    let date1 = calendar.startOfDay(for: Date())
    let date2 = calendar.startOfDay(for: selected)
    let components = calendar.dateComponents([.day], from: date1, to: date2)
    let days = components.day
    return days ?? 0
}

extension UILabel{
    func setHTMLFromString(text: String) {
        let modifiedFont = NSString(format:"<span style=\"font-family: \(self.font!.fontName); font-size: \(14)\">%@</span>" as NSString, text)
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: String.Encoding.unicode.rawValue, allowLossyConversion: true)!,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        self.attributedText = attrStr
    }
}

class PlaceholderTextView: UITextView {
    
    let placeholdeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Type message..."
        lbl.textColor = UIColor.lightGray
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    func setPlaceholder(text: String) {
        placeholdeLabel.text = text
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(placeAction), name: UITextView.textDidChangeNotification, object: nil)
        
        self.addSubview(placeholdeLabel)
        
        self.isScrollEnabled = false
        self.sizeToFit()
        
        NSLayoutConstraint.activate([
            placeholdeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            placeholdeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5)
        ])
    }
    
    @objc func placeAction() {
        placeholdeLabel.isHidden = !self.text.isEmpty
    }
}

extension UIViewController {
    func checkdate(selected:Date) -> Bool{
        let calender = Calendar.current
        let nowDay = calender.component(.day, from: Date())
        let nowMonth = calender.component(.month, from: Date())
        let nowYear = calender.component(.year, from: Date())
        let selectedDay = calender.component(.day, from: selected)
        let selectedMonth = calender.component(.month, from: selected)
        let selectedYear = calender.component(.year, from: selected)
        if nowYear > selectedYear{
            return false
        }else if nowYear == selectedYear{
            if nowMonth > selectedMonth{
                return false
            }else if nowMonth == selectedMonth{
                if nowDay > selectedDay{
                    return false
                }else{
                    return true
                }
            }else{
                return true
            }
        }else{
            return true
        }
    }
    func checkTime(selected: Date) -> Bool{
        let calender = Calendar.current
        let nowDay = calender.component(.day, from: Date())
        let nowMonth = calender.component(.month, from: Date())
        let nowYear = calender.component(.year, from: Date())
        let selectedDay = calender.component(.day, from: selected)
        let selectedMonth = calender.component(.month, from: selected)
        let selectedYear = calender.component(.year, from: selected)
        let nowHour = calender.component(.hour, from: Date())
        let nowMin = calender.component(.minute, from: Date())
        let selectedHour = calender.component(.hour, from: selected)
        let selectedMin = calender.component(.minute, from: selected)
        if nowYear == selectedYear && nowMonth == selectedMonth && nowDay == selectedDay{
            if nowHour > selectedHour{
                return false
            }else if nowHour == selectedHour{
                if nowMin > selectedMin{
                    return false
                }else{
                    return true
                }
            }else{
                return true
            }
        }else{
            return true
        }
    }
}
extension UIViewController {
    func getImg(url: String, img: UIImageView) {
        guard let u = URL(string: url) else {return}
        URLSession.shared.dataTask(with: u) { (data, response, err) in
            guard let data = data else {return}
            DispatchQueue.main.async {
                img.image = UIImage(data: data)
            }
        }.resume()
    }
}
//extension UIButton {
//    func localize() {
//        if MOLHLanguage.currentAppleLanguage() == "ar" {
//            self.transform = CGAffineTransform(scaleX: -1, y: 1)
//        }
//    }
//}
//extension UIImageView {
//    func localize() {
//        if MOLHLanguage.currentAppleLanguage() == "ar" {
//            self.transform = CGAffineTransform(scaleX: -1, y: 1)
//        }
//    }
//}

extension UIViewController {
    func openURL(url: String) {
        if let url = URL(string: url) {
            UIApplication.shared.open(url)
        }
    }
}
