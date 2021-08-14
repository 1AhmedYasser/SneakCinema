//
//  CreateSession.swift
//  Sneak Cinema
//
//  Created by Ahmed Yasser on 07/08/2021.
//

import Foundation

// MARK: - CreateSessionWithLogin
struct CreateSessionWithLogin: Codable {
    let success: Bool?
    let expires_at, request_token: String?
}
