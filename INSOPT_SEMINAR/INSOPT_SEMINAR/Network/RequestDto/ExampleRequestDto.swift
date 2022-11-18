//
//  ExampleRequestDto.swift
//  INSOPT_SEMINAR
//
//  Created by hansol on 2022/11/05.
//

import Foundation

// MARK: - ProfileRequestDto

struct ProfileRequestDto: Codable {
    let userId: Int
}

// MARK: - EventRequestDto

struct EventRequestDto: Codable {
    let date: EventDateDto
    let userId: Int
}

// MARK: - EventDateDto

struct EventDateDto: Codable {
    let startDate: String
    let endDate: String
}

// MARK: - AddSongRequestDto

struct AddSongRequestDto: Codable {
    let image: Data
    let singer: String
    let title: String
}
