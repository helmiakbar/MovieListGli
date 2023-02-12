//
//  ViewControllerAssembly.swift
//  TestGLI
//
//  Created by SehatQ on 11/02/23.
//

import Swinject

class ViewControllerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeViewController.self) { _ in
            return HomeViewController()
        }
        
        container.register(MovieDetailViewController.self) { (_: Resolver, movieId: Int) in
            let movieDetailVC = MovieDetailViewController(movieId: movieId)
            return movieDetailVC
        }
    }
    
}
