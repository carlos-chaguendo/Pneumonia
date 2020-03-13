//
//  ScanResultCollectionViewCell.swift
//  Pneumonia
//
//  Created by Carlos Chaguendo on 13/03/20.
//  Copyright © 2020 FUP. All rights reserved.
//

import UIKit

class ScanResultCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var visualEfectView: UIVisualEffectView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var confidence: UILabel!
    @IBOutlet weak var label: UILabel!
    
    public var scan: ScanResult! {
        didSet {
            imageView.image = scan.image
            confidence.text = String(format: "%.2f", scan.confidence) 
            label.text = scan.label
            
            imageView.layer.cornerRadius = 12
            imageView.layer.masksToBounds = true
            
            visualEfectView.layer.cornerRadius = 11.5
              visualEfectView.layer.masksToBounds = true
            
            
//            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topRight, .bottomLeft], cornerRadii: CGSize(width: 12, height: 12))
//
//            let mask = CAShapeLayer()
//            mask.path = path.cgPath
//
//            visualEfectView.layer.mask = mask
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 12
        layer.masksToBounds = true
        
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 0.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = traitCollection.userInterfaceStyle == .dark ? UIColor.black.cgColor: UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width:0, height: 0)
        layer.shadowRadius = 14.0
        layer.shadowOpacity = 0.6
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    

    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        layer.shadowColor = traitCollection.userInterfaceStyle == .dark ? UIColor.black.cgColor: UIColor.lightGray.cgColor
    }
    
}
