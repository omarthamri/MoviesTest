//
//  HomeCoordinator.swift
//  MoviesTest
//
//  Created by omar thamri on 20/5/2024.
//

import UIKit

class HomeCoordinator: NSObject,Coordinator {
    
    var rootViewController: UINavigationController
    let viewModel = HomeViewModel()
    lazy var homeViewController: HomeViewController = {
           let vc = HomeViewController()
            vc.viewModel = viewModel
            vc.showDetailRequest = { [weak self] row in
                self?.goToDetails(row: row)
            }
            vc.title = "Trending Movies"
            return vc
        }()
        
        override init() {
            rootViewController = UINavigationController()
            super.init()
        }
    
    func start() {
        rootViewController.setViewControllers([homeViewController], animated: false)
    }
    
    func goToDetails(row: Int) {
        let detailViewController = DetailMovieViewController(movieId: viewModel.movies[row].id)
        rootViewController.pushViewController(detailViewController, animated: true)
        }
}

