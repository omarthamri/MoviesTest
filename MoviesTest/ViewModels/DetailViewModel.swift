//
//  DetailViewModel.swift
//  MoviesTest
//
//  Created by omar thamri on 20/5/2024.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var movie: Movie?
    @Published var movieId: Int
    @Published var error: String?
    
    init(movieId: Int) {
        self.movieId = movieId
        self.fetchMoviesDetails()
    }
    
    func fetchMoviesDetails() {
        APICaller.shared.getMoviesDetails(movieId: movieId, completion: { [weak self] result in
            switch result {
            case .success(let movie):
                self?.movie = movie
            case .failure(let error):
                self?.error = error.localizedDescription
            }
        })
    }
}
