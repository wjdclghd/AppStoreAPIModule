//
//  SearchDetailEntity.swift
//  CleanArchitectureiOS
//
//  Created by jch on 6/29/25.
//

import Foundation

public struct SearchDetailEntity: Identifiable, Codable, Equatable, Hashable {
    public let id: Int
    public let trackName: String?
    public let artistName: String?
    public let artworkUrl100: String?
    public let description: String?
    public let averageUserRating: Double?
    public let userRatingCount: Int?
    public let screenshotUrls: [String]?
    public let genres: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case trackName
        case artistName
        case artworkUrl100
        case description
        case averageUserRating
        case userRatingCount
        case screenshotUrls
        case genres
    }
}
