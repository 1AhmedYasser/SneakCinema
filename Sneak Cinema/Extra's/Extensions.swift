//
//  Extensions.swift
//  Sneak Cinema
//
//  Created by Ahmed Yasser on 14/07/2021.
//

import Foundation
import UIKit

@IBDesignable
class CinemaView: UIView{}
@IBDesignable
class CinemaButton: UIButton{}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var maskToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
    @available(iOS 11.0,*)
    @IBInspectable var MaskedCorners: String {
        get {
            return ""
        }
        set {
            layer.maskedCorners = []
            if newValue.contains("1") {
                layer.maskedCorners.update(with: .layerMaxXMinYCorner)
            }
            if newValue.contains("2") {
                layer.maskedCorners.update(with: .layerMinXMinYCorner)
            }
            if newValue.contains("3") {
                layer.maskedCorners.update(with: .layerMinXMaxYCorner)
            }
            if newValue.contains("4") {
                layer.maskedCorners.update(with: .layerMaxXMaxYCorner)
            }
        }
    }
    
    func rotate(toDegrees angleInDegrees: CGFloat) {
        let angleInRadians = angleInDegrees / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: angleInRadians)
        self.transform = rotation
    }
}
