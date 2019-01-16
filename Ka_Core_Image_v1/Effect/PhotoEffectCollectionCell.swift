//
//  PhotoEffectCollectionCell.swift
//  Ka_Core_Image_v1
//
//  Created by Viet Asc on 1/16/19.
//  Copyright © 2019 Viet Asc. All rights reserved.
//

import UIKit

class PhotoEffectCollectionCell: UICollectionViewCell {
    
    let kCellWidth: CGFloat = 66
    let kLabelHeight: CGFloat = 20
    var name: String!
    var filterNameLabel: UILabel!
    var filteredImageView: ViewFilter!
    var filter: CIFilter?
    
    override var isSelected: Bool {
        didSet {
            filteredImageView.layer.borderWidth = isSelected ? 2 : 0
        }
    }
    
    lazy var add = {
        
        if self.filteredImageView == nil {
            
            self.filteredImageView = ViewFilter(frame: CGRect(x: 0, y: 0, width: self.kCellWidth, height: self.kCellWidth))
            self.filteredImageView.layer.borderColor = self.tintColor.cgColor
            self.contentView.addSubview(self.filteredImageView)
            
        }
        
        if self.filterNameLabel == nil {
            
            self.filterNameLabel = UILabel(frame: CGRect(x: 0, y: self.kCellWidth, width: self.kCellWidth, height: self.kLabelHeight))
            self.filterNameLabel.textAlignment = .center
            self.filterNameLabel.textColor = UIColor(white: 0.9, alpha: 1.0)
            self.filterNameLabel.highlightedTextColor = self.tintColor
            self.filterNameLabel.font = UIFont.systemFont(ofSize: 12)
            self.contentView.addSubview(self.filterNameLabel)
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        add()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        add()
        
    }
    
    override var intrinsicContentSize: CGSize {
        
        return CGSize(width: kCellWidth, height: kCellWidth + kLabelHeight)
        
    }
    
}
