//
//  Extensions.swift
//  UdemyInstrumentos
//
//  Created by Cristian Misael Almendro Lazarte on 9/9/18.
//  Copyright © 2018 Cristian Misael Almendro Lazarte. All rights reserved.
//

import UIKit

@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat{
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    
    @IBInspectable var cornerRadius : CGFloat{
        set{
            layer.cornerRadius = newValue
        }
        get{
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor : UIColor? {
        set{
            guard let uiColor = newValue else {return}
            layer.borderColor = uiColor.cgColor
        }
        get{
            guard let color = layer.borderColor else {return nil}
            return UIColor(cgColor: color)
        }
    }
    
}
