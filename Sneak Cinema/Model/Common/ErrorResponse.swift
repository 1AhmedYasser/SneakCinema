//
//  ErrorResponse.swift
//  Sneak Cinema
//
//  Created by Ahmed Yasser on 07/08/2021.
//

import Foundation

// MARK: - ErrorResponse
struct ErrorResponse: Codable {
    let status_code: Int?
    let status_message: String?
}
