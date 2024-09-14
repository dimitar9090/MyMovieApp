import UIKit
import SwiftUI

struct MovieModel: Decodable, Identifiable {
    let id: Int
    let title: String
    let vote_average: Double // Рейтинг
    let poster_path: String? // Път към постера
    let overview: String? // Описание на филма (добавено поле)
}

class MoviesViewController: UIViewController {
    
    var movies: [MovieModel] = [] // Използваме MovieModel
    var hostingController: UIHostingController<MovieListView>? // Хостинг контролер за SwiftUI изгледа
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Създаваме празен списък първоначално
        let swiftUIView = MovieListView(movies: [], onMovieSelect: { movie in
            self.showMovieDetail(movie: movie)
        })
        
        // Свързваме SwiftUI изгледа с UIKit
        hostingController = UIHostingController(rootView: swiftUIView)
        guard let hostingController = hostingController else { return }
        
        addChild(hostingController)
        hostingController.view.frame = self.view.bounds
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        // Стартираме извличането на филмите
        fetchMoviesFromAPI()
    }
    
    func fetchMoviesFromAPI() {
        let apiKey = "fcd4f865cc4f813896649cc8fea50296" // API ключът
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching movies: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                // Декодираме JSON отговорът
                let decodedResponse = try JSONDecoder().decode(TMDBResponse.self, from: data)
                self?.movies = decodedResponse.results
                
                // Обновяваме UI на главния thread
                DispatchQueue.main.async {
                    self?.updateMovieList()
                }
                
            } catch let decodingError {
                print("Error decoding JSON: \(decodingError)")
            }
        }
        
        task.resume()
    }
    
    func updateMovieList() {
        // Обновяваме SwiftUI изгледа със заредените филми
        guard let hostingController = hostingController else { return }
        
        let swiftUIView = MovieListView(movies: movies, onMovieSelect: { [weak self] movie in
            self?.showMovieDetail(movie: movie)
        })
        
        // Обновяваме съдържанието на хостинг контролера
        hostingController.rootView = swiftUIView
    }
    
    func showMovieDetail(movie: MovieModel) {
        let moviePosterURL = "https://image.tmdb.org/t/p/w500" + (movie.poster_path ?? "")
        let movieRating = movie.vote_average
        let movieDescription = movie.overview ?? "Няма описание за този филм." // Реално описание или fallback текст

        let detailView = MovieDetailView(
            movieTitle: movie.title,
            movieDescription: movieDescription, // Използваме реалното описание
            movieRating: movieRating,
            moviePosterURL: moviePosterURL
        )

        let detailHostingController = UIHostingController(rootView: detailView)
        self.navigationController?.pushViewController(detailHostingController, animated: true)
    }
    
    // Модели за декодиране на API отговора
    struct TMDBResponse: Decodable {
        let results: [MovieModel] // Използваме MovieModel
    }
}
