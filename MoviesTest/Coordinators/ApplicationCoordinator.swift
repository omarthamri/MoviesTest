//
//  ApplicationCoordinator.swift
//  MoviesTest
//
//  Created by omar thamri on 20/5/2024.
//

import UIKit
import Combine

protocol Coordinator {
    
    func start()
    
}

class ApplicationCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    let window: UIWindow
       init(window: UIWindow) {
           self.window = window
       }
    
    func start() {
        let homeCoordinator = HomeCoordinator()
        homeCoordinator.start()
        childCoordinators = [homeCoordinator]
        window.rootViewController = homeCoordinator.rootViewController
    }
    
    
    
    
    
}
