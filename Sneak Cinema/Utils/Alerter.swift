//
//  Alerter.swift
//  Sneak Cinema
//
//  Created by Ahmed Yasser on 14/08/2021.
//

import Foundation
import UIKit

class Alerter {
    
    class func showAlert(title: String = "Sneak Cinema", message: String, controller: UIViewController, withCancel: Bool = false, style: UIAlertController.Style = UIAlertController.Style.alert) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okAction)
        if (withCancel) {
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(cancelAction)
        }
        controller.present(alert, animated: true, completion: nil)
    }
}
