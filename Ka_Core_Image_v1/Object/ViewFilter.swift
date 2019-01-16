//
//  ViewFilter.swift
//  Ka_Core_Image_v1
//
//  Created by Viet Asc on 1/16/19.
//  Copyright © 2019 Viet Asc. All rights reserved.
//

import UIKit

class ViewFilter: UIImageView {
    
    var imageFilter: UIImage?
    
    lazy var editedImage = { (_ filter: CIFilter) -> UIImage in
        
        let outputImage = filter.outputImage
        let ciContext = CIContext()
        let ouptImageRef = ciContext.createCGImage(outputImage!, from: outputImage!.extent)
        let uiImage = UIImage(cgImage: ouptImageRef!)
        return uiImage
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
