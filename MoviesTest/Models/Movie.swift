//
//  Movie.swift
//  MoviesTest
//
//  Created by omar thamri on 20/5/2024.
//

import Foundation

struct TrendingMovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    
    let adult: Bool?
    let backdrop_path: String?
    let first_air_date: String?
    let genre_ids: [Int]?
    let id: Int
    let name: String?
    let media_type: String?
    let origin_country: [String]?
    let original_language: String?
    let original_name: String?
    let original_title: String?
    let popularity: Double?
    let poster_path: String?
    let overview: String?
    let vote_count: Int?
    let release_date: String?
    let title: String?
    let video: Bool?
    let vote_average: Double?
    
}
