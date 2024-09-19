import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    var movies: [MovieModel]
    var favoriteMovies: [MovieModel]
    var onMovieSelect: (MovieModel) -> Void
    var onToggleFavorite: (MovieModel) -> Void
    
    var filteredMovies: [MovieModel] {
        if searchText.isEmpty {
            return []
        } else {
            return movies.filter { movie in
                movie.title.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        VStack {
            TextField("Search for movies", text: $searchText)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
                .foregroundColor(.white)

            if !filteredMovies.isEmpty {
                List(filteredMovies, id: \.id) { movie in
                    HStack {
                        Text(movie.title)
                            .foregroundColor(.white)
                        Spacer()
                        Button(action: {
                            onToggleFavorite(movie)
                        }) {
                            Image(systemName: favoriteMovies.contains(where: { $0.id == movie.id }) ? "heart.fill" : "heart")
                        }
                    }
                    .onTapGesture {
                        onMovieSelect(movie)
                    }
                }
            } else {
                Text("No results found")
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}
