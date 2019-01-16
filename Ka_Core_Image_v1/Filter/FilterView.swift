//
//  FilterView.swift
//  Ka_Core_Image_v1
//
//  Created by Viet Asc on 1/16/19.
//  Copyright © 2019 Viet Asc. All rights reserved.
//

import UIKit

class FilterView: UIViewController {
    
    @IBOutlet weak var imgFilterView: ViewFilter!
    @IBOutlet weak var subView: UIView!
    
    let kSliderHeight: CGFloat = 37
    let kSliderMarginY: CGFloat = 2
    var add = false
    var nameFilter: String?
    var image: UIImage?
    var filter: CIFilter!
    
    lazy var descriptor = { () -> [ObjectPara] in
        
        var arrPara = [ObjectPara]()
        for inputName in self.filter.inputKeys {
            if inputName != "inputImage" {
                let attributes = self.filter.attributes
                let attribute = attributes[inputName] as! [String: AnyObject]
                let minValue = attribute[kCIAttributeSliderMin] as! Float
                let maxValue = attribute[kCIAttributeSliderMax] as! Float
                let defaultValue = attribute[kCIAttributeDefault] as! Float
                arrPara.append(ObjectPara(inputName, inputName, minValue, maxValue, defaultValue))
            }
        }
        return arrPara
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgFilterView.image = image!
        let ciImage = CIImage(image: imgFilterView.image!)
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        
    }
    
    override func viewDidLayoutSubviews() {
        
        if !add {
            
            add = true
            let arrPara = descriptor()
            let heightSlider = (self.subView.frame.height - kSliderMarginY * CGFloat(arrPara.count)) / CGFloat(arrPara.count)
            var yOffset: CGFloat = 0
            for obj in arrPara {
                let view = CustomView(frame: CGRect(x: 0, y: self.subView.frame.origin.y + yOffset + kSliderMarginY, width: self.view.frame.size.width, height: heightSlider), parameter: obj)
                view.parameter = obj
                view.delegate = self
                yOffset += kSliderMarginY + heightSlider
                self.view.addSubview(view)
            }
            
        }
        
    }
    
    @IBAction func saveImg(_ sender: AnyObject) {
        
        UIImageWriteToSavedPhotosAlbum(imgFilterView.image!, self, nil, nil)
        
    }
    
}

extension FilterView: ParameterAdjustmentDelegate {
    
    func parameterValueDidChange(_ parameter: ObjectPara) {
        
        filter.setValue(parameter.currentValue, forKey: parameter.key)
        let tool = ViewFilter(frame: CGRect())
        let aCIImage = tool.editedImage(filter)
        imgFilterView.image = aCIImage
        
    }
    
}
