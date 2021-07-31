//
//  Validator.swift
//  Sneak Cinema
//
//  Created by Ahmed Yasser on 31/07/2021.
//

import Foundation
import UIKit

class Validator {
    
    func validate(text: String, with rules: [Rule]) -> String? {
        return rules.compactMap({ $0.check(text) }).first
    }

    func validate(input: UITextField, with rules: [Rule]) -> String {
        guard let message = validate(text: input.text ?? "", with: rules) else {
            return ""
        }

        return message
    }
    
}

struct Rule {

    let check: (String) -> String?

    static let notEmpty = Rule { text in
        return text.isEmpty ? "Empty Field" : nil
    }
    
    static let validEmail = Rule { text in
        let regex = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: text) ? nil : "Invalid Email"
    }
}
