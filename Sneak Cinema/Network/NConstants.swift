//
//  NConstants.swift
//  Sneak Cinema
//
//  Created by Ahmed Yasser on 31/07/2021.
//

import Foundation
import Alamofire

class NConstants {
    static let baseURL:String = "https://api.themoviedb.org/3/"
    
    // MARK: Endpoints - // Models
    
    // Authentication
    static let guestSession = ("authentication/guest_session/new", GuestSession.self)
    static let createRequestToken = ("authentication/token/new", RequestTokenCreation.self)

    static func endpoint(_ endpoint: String) -> URL {
        return "\(baseURL)\(endpoint)".url
    }
}
