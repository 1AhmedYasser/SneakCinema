//
//  CinemaNetworkConfig.swift
//  Sneak Cinema
//
//  Created by Ahmed Yasser on 31/07/2021.
//

import Foundation
import UIKit
import Alamofire

class CinemaNetworkConfig {
    
    class func getHeaders() -> HTTPHeaders {
        return [
            "Content-Type": "application/json",
        ]
    }
    
    enum RequestEncoding {
        case url,json
    }
}
