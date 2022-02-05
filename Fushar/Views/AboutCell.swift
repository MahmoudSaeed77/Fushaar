//
//  AboutCell.swift
//  Fushar
//
//  Created by Mohamed Ibrahem on 1/12/22.
//  Copyright © 2022 Mahmoud Saeed. All rights reserved.
//

import UIKit

class AboutCell: UICollectionViewCell {
    @IBOutlet weak var pointView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        pointView.layer.cornerRadius = 4
        pointView.clipsToBounds = true
    }
}
