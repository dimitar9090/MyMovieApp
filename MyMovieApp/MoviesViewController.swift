//
//  MoviesViewController.swift
//  MyMovieApp
//
//  Created by Dimitar Angelov on 11.09.24.
//

import UIKit
import SwiftUI

class MoviesViewController: UIViewController {
    
    var movies: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMoviesFromAPI() // Извличаме филмите от API
        
        let swiftUIView = MovieListView(movies: movies, onMovieSelect: { movie in
            self.showMovieDetail(movie: movie)
        })
        
        let hostingController = UIHostingController(rootView: swiftUIView)
        addChild(hostingController)
        hostingController.view.frame = self.view.bounds
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
    
    func fetchMoviesFromAPI() {
        let apiKey = "fcd4f865cc4f813896649cc8fea50296" // Тук постави своя API ключ
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching movies: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decodedResponse = try JSONDecoder().decode(TMDBResponse.self, from: data)
                self.movies = decodedResponse.results.map { $0.title }
                
                // Обновяваме UI на главния thread
                DispatchQueue.main.async {
                    // Обновяване на списъка с филми
                    self.viewDidLoad()
                }
                
            } catch let decodingError {
                print("Error decoding JSON: \(decodingError)")
            }
        }
        
        task.resume()
    }
    
    func showMovieDetail(movie: String) {
        let detailView = MovieDetailView(movieTitle: movie, movieDescription: "Това е описание на филма \(movie).")
        let detailHostingController = UIHostingController(rootView: detailView)
        self.navigationController?.pushViewController(detailHostingController, animated: true)
    }
}

struct TMDBResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let title: String
}
