import SwiftUI

struct MovieListView: View {
    @State private var searchText = ""
    var movies: [MovieModel] // Използваме MovieModel вместо String
    var onMovieSelect: (MovieModel) -> Void

    var filteredMovies: [MovieModel] {
        if searchText.isEmpty {
            return movies
        } else {
            return movies.filter { movie in
                movie.title.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        NavigationView {
            List(filteredMovies, id: \.id) { movie in
                Button(action: {
                    onMovieSelect(movie) // Извиква се при натискане на филм
                }) {
                    Text(movie.title)
                }
            }
            .navigationTitle("Movies")
            .searchable(text: $searchText, prompt: "Search for movies or actors")
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(movies: [MovieModel(id: 1, title: "Inception", vote_average: 8.8, poster_path: nil)], onMovieSelect: { _ in })
    }
}
