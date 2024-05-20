//
//  HomeViewModel.swift
//  MoviesTest
//
//  Created by omar thamri on 20/5/2024.
//

import Foundation
import Combine


class HomeViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var error: String?
    var row: Int?
    
    func fetchTrendingMovies() {
       APICaller.shared.getTrendingMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
            case .failure(let error):
                self?.error = error.localizedDescription
            }
        }
    }
    
    
}

