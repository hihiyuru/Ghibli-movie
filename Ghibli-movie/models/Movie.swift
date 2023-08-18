//
//  Movie.swift
//  Ghibli-movie
//
//  Created by 徐于茹 on 2023/8/17.
//

import Foundation

struct Movie: Decodable {
    let id: String
    let title: String
    let originalTitle: String
    let originalTitleRomanised: String
    let image: URL
    let movieBanner: URL
    let description: String
    let director: String
    let producer: String
    let releaseDate: String
    let runningTime: String
    let rtScore: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case originalTitleRomanised = "original_title_romanised"
        case image
        case movieBanner = "movie_banner"
        case description
        case director
        case producer
        case releaseDate = "release_date"
        case runningTime = "running_time"
        case rtScore = "rt_score"
        case url
    }
}
