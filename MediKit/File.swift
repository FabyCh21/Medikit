//
//  File.swift
//  MediKit
//
//  Created by administrador on 21/9/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import Foundation

extension UITextField{
    var placeHolderColor: UIColor? {
        get{
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder, !=nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: newValue!])
        }
    }
}





