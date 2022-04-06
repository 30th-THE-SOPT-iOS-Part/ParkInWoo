//
//  PadedTextField.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/06.
//

import UIKit

class PadedTextField: UITextField {
    
    var insetX: CGFloat = 10
    var insetY: CGFloat = 10
    
    convenience init(insetX: CGFloat, insetY: CGFloat) {
        self.init()
        self.insetX = insetX
        self.insetY = insetY
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
}
