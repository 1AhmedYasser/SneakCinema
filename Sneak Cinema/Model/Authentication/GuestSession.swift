//
//  GuestSession.swift
//  Sneak Cinema
//
//  Created by Ahmed Yasser on 31/07/2021.
//

import Foundation

// MARK: - GuestSession
struct GuestSession: Codable {
    let success: Bool?
    let guest_session_id, expires_at: String?
}
