import UIKit
import SwiftUI

class MoviesViewController: UIViewController {
    
    var movies: [MovieModel] = [] // All movies
    var favoriteMovies: [MovieModel] = [] // Favorite movies
    var hostingController: UIHostingController<MoviesListWithSectionsView>? // Hosting controller for SwiftUI

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFavoriteMovies() // Load favorite movies
        
        let swiftUIView = MoviesListWithSectionsView(
            topRatedMovies: getTopRatedMovies(),
            popularMovies: getPopularMovies(),
            latestMovies: getLatestMovies(),
            favoriteMovies: favoriteMovies,
            onMovieSelect: { [weak self] movie in
                self?.showMovieDetail(movie: movie)
            },
            onToggleFavorite: { [weak self] movie in
                self?.toggleFavorite(movie: movie)
            },
            onDeleteFavorite: { [weak self] movie in // Добавяме onDeleteFavorite
                self?.deleteFavorite(movie: movie)
            }
        )
        
        hostingController = UIHostingController(rootView: swiftUIView)
        guard let hostingController = hostingController else { return }
        
        addChild(hostingController)
        hostingController.view.frame = self.view.bounds
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        fetchMoviesFromAPI() // Load movies
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

    func deleteFavorite(movie: MovieModel) {
        favoriteMovies.removeAll { $0.id == movie.id }
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
        
        let swiftUIView = MoviesListWithSectionsView(
            topRatedMovies: getTopRatedMovies(),
            popularMovies: getPopularMovies(),
            latestMovies: getLatestMovies(),
            favoriteMovies: favoriteMovies,
            onMovieSelect: { [weak self] movie in
                self?.showMovieDetail(movie: movie)
            },
            onToggleFavorite: { [weak self] movie in
                self?.toggleFavorite(movie: movie)
            },
            onDeleteFavorite: { [weak self] movie in
                self?.deleteFavorite(movie: movie)
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

    // Helper functions for getting categorized movies
    func getTopRatedMovies() -> [MovieModel] {
        return movies.sorted(by: { $0.vote_average > $1.vote_average }).prefix(10).map { $0 }
    }

    func getPopularMovies() -> [MovieModel] {
        // Replace with real logic for fetching popular movies
        return movies.prefix(10).map { $0 }
    }

    func getLatestMovies() -> [MovieModel] {
        // Replace with real logic for fetching the latest movies
        return movies.suffix(10).map { $0 }
    }

    struct TMDBResponse: Decodable {
        let results: [MovieModel]
    }
}
