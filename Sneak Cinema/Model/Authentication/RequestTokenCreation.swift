//
//  RequestTokenCreation.swift
//  Sneak Cinema
//
//  Created by Ahmed Yasser on 31/07/2021.
//

import Foundation

// MARK: - RequestTokenCreation
struct RequestTokenCreation: Codable {
    let success: Bool?
    let expires_at, request_token: String?
}
