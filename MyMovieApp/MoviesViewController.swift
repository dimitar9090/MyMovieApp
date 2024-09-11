//
//  MoviesViewController.swift
//  MyMovieApp
//
//  Created by Dimitar Angelov on 11.09.24.
//

import UIKit
import SwiftUI

class MoviesViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swiftUIView = MovieListView(movies: ["Inception", "Interstellar", "The Dark Knight"], onMovieSelect: { movie in
            self.showMovieDetail(movie: movie)
        })
        
        let hostingController = UIHostingController(rootView: swiftUIView)
        addChild(hostingController)
        hostingController.view.frame = self.view.bounds
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }

    // Функция за показване на детайлен изглед
    func showMovieDetail(movie: String) {
        let detailView = MovieDetailView(movieTitle: movie, movieDescription: "Това е описание на филма \(movie).")
        let detailHostingController = UIHostingController(rootView: detailView)
        self.navigationController?.pushViewController(detailHostingController, animated: true)
    }
}
