import UIKit
import SwiftUI

class MoviesViewController: UIViewController {
    
    var movies: [MovieModel] = [] // Списък с всички филми
    var favoriteMovies: [MovieModel] = [] // Списък с любими филми
    var hostingController: UIHostingController<MovieListView>? // Хостинг контролер за SwiftUI изгледа

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFavoriteMovies() // Зареждаме любимите филми
        
        let swiftUIView = MovieListView(
            movies: movies,
            favoriteMovies: favoriteMovies,
            onMovieSelect: { movie in
                self.showMovieDetail(movie: movie)
            },
            onToggleFavorite: { movie in
                self.toggleFavorite(movie: movie)
            },
            onShowFavorites: { [weak self] in
                self?.showFavorites()
            }
        )
        
        hostingController = UIHostingController(rootView: swiftUIView)
        guard let hostingController = hostingController else { return }
        
        addChild(hostingController)
        hostingController.view.frame = self.view.bounds
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        fetchMoviesFromAPI() // Зареждаме филмите
    }

    func showMovieDetail(movie: MovieModel) {
        let detailView = MovieDetailView(movie: movie)
        let detailHostingController = UIHostingController(rootView: detailView)
        self.navigationController?.pushViewController(detailHostingController, animated: true)
    }

    func toggleFavorite(movie: MovieModel) {
        if favoriteMovies.contains(where: { $0.id == movie.id }) {
            favoriteMovies.removeAll { $0.id == movie.id }
        } else {
            favoriteMovies.append(movie)
        }
        saveFavoriteMovies()
        updateMovieList()
    }

    func saveFavoriteMovies() {
        if let encodedData = try? JSONEncoder().encode(favoriteMovies) {
            UserDefaults.standard.set(encodedData, forKey: "favoriteMovies")
        }
    }

    func loadFavoriteMovies() {
        if let savedData = UserDefaults.standard.data(forKey: "favoriteMovies"),
           let decodedMovies = try? JSONDecoder().decode([MovieModel].self, from: savedData) {
            favoriteMovies = decodedMovies
        }
    }

    func updateMovieList() {
        guard let hostingController = hostingController else { return }
        
        let swiftUIView = MovieListView(
            movies: movies,
            favoriteMovies: favoriteMovies,
            onMovieSelect: { [weak self] movie in
                self?.showMovieDetail(movie: movie)
            },
            onToggleFavorite: { [weak self] movie in
                self?.toggleFavorite(movie: movie)
            },
            onShowFavorites: { [weak self] in
                self?.showFavorites()
            }
        )
        hostingController.rootView = swiftUIView
    }

    func fetchMoviesFromAPI() {
        let apiKey = "fcd4f865cc4f813896649cc8fea50296"
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching movies: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decodedResponse = try JSONDecoder().decode(TMDBResponse.self, from: data)
                self?.movies = decodedResponse.results
                
                DispatchQueue.main.async {
                    self?.updateMovieList()
                }
                
            } catch let decodingError {
                print("Error decoding JSON: \(decodingError)")
            }
        }
        
        task.resume()
    }

    func showFavorites() {
        let favoritesView = MovieListView(
            movies: favoriteMovies,
            favoriteMovies: favoriteMovies,
            onMovieSelect: { [weak self] movie in
                self?.showMovieDetail(movie: movie)
            },
            onToggleFavorite: { [weak self] movie in
                self?.toggleFavorite(movie: movie)
            },
            onShowFavorites: { }
        )
        let favoritesHostingController = UIHostingController(rootView: favoritesView)
        self.navigationController?.pushViewController(favoritesHostingController, animated: true)
    }

    struct TMDBResponse: Decodable {
        let results: [MovieModel]
    }
}
