//
//  UserResponseDto.swift
//  INSOPT_SEMINAR
//
//  Created by hansol on 2022/11/05.
//

import Foundation

// MARK: - LoginResponseDto
struct LoginResponseDto: Codable {
    let status: Int
    let message: String
    let result: Results?
}

// MARK: - Result
struct Results: Codable {
    let id: Int
    let name: String
    let profileImage, bio: String?
    let email, password: String
}

