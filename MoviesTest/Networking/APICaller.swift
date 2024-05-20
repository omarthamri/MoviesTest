//
//  APICaller.swift
//  MoviesTest
//
//  Created by omar thamri on 20/5/2024.
//

import Foundation

struct Constants {
    static let API_KEY = "c9856d0cb57c3f14bf75bdc6c063b8f3"
    static let ListMoviesBaseURL = "https://api.themoviedb.org"
    static let detailMovieBaseURL = "https://developers.themoviedb.org"
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Movie],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.ListMoviesBaseURL)/3/discover/movie?api_key=\(Constants.API_KEY)") else {
            
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getMoviesDetails(movieId: Int,completion: @escaping (Result<Movie,Error>) -> Void) {
        guard let url = URL(string: "\(Constants.ListMoviesBaseURL)/3/movie/\(movieId)?api_key=\(Constants.API_KEY)") else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(Movie.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
}

