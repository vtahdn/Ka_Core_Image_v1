//
//  CustomView.swift
//  Ka_Core_Image_v1
//
//  Created by Viet Asc on 1/16/19.
//  Copyright © 2019 Viet Asc. All rights reserved.
//

import UIKit

protocol ParameterAdjustmentDelegate {
    
    func parameterValueDidChange(_ parameter: ObjectPara)
    
}

class CustomView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    var parameter: ObjectPara!
    var delegate: ParameterAdjustmentDelegate?
    
    lazy var add = {
        
        guard let parameter = self.parameter else { return }
        self.slider.minimumValue = parameter.minimumValue!
        self.slider.maximumValue = parameter.maximumValue!
        self.slider.value = parameter.currentValue
        self.descriptionLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.descriptionLabel.textColor = UIColor(white: 0.9, alpha: 1)
        self.descriptionLabel.text = parameter.name
        self.value.font = UIFont.systemFont(ofSize: 14)
        self.value.textColor = UIColor(white: 0.9, alpha: 1.0)
        self.value.textAlignment = .right
        self.value.text = self.slider.value.description
        
    }
    
    lazy var load = {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CustomView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        
    }
    
    init(frame: CGRect, parameter: ObjectPara) {
        super.init(frame: frame)
        
        self.parameter = parameter
        load()
        add()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func sliderValueDidChange(_ sender: AnyObject?) {
        
        value.text = String(format: "%0.2f", slider.value)
        
    }
    
    @IBAction func sliderTouchUpInSide(_ sender: AnyObject?) {
        
        if delegate != nil {
            delegate!.parameterValueDidChange(ObjectPara(parameter.key, slider.value))
        }
        
    }
    
}
