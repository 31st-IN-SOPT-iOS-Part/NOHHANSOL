//
//  ExampleResponseDto.swift
//  INSOPT_SEMINAR
//
//  Created by hansol on 2022/11/05.
//

import Foundation

// MARK: - ProfileResponseDto

struct ProfileResponseDto: Codable {
    let name: String
    let gender: String
    let age: Int
    let score: Int
}

// MARK: - EventResponseDto

struct EventResponseDto: Codable {
    let eventInfoDtos: [EventInfoDto]
}

// MARK: - EventInfoDto

struct EventInfoDto: Codable {
    let date: String
    let eventName: String
    let count: Int
    let place: String
}

// MARK: - AddSongResponseDto

struct AddSongResponseDto: Codable {
    let statusCode: Int
    let success: Bool
    let message: String
    let data: SongDto
}

// MARK: - DataClass

struct SongDto: Codable {
    let id: Int
    let image: String
    let title, singer: String
}
