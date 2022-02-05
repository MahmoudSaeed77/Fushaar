//
//  HomeCell.swift
//  Fushar
//
//  Created by Mohamed Ibrahem on 1/12/22.
//  Copyright © 2022 Mahmoud Saeed. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var rateLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        moreBtn.imageView?.image = moreBtn.imageView?.image?.withTintColor(.darkGray)
//        moreBtn.imageView?.image = moreBtn.imageView?.image?.withRenderingMode(.alwaysTemplate)
    }
}
