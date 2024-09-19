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
            // Search bar
            TextField("Search for movies", text: $searchText)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
                .foregroundColor(.white)

            // Movie list or no results message
            if !filteredMovies.isEmpty {
                List(filteredMovies, id: \.id) { movie in
                    HStack {
                        Text(movie.title)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        // Favorite toggle button
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
        .background(Color.black.edgesIgnoringSafeArea(.all)) // Background color
    }
}

// Preview
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(
            movies: [
                MovieModel(id: 1, title: "Inception", vote_average: 8.8, poster_path: "/poster1.jpg", overview: "A mind-bending thriller about dreams within dreams."),
                MovieModel(id: 2, title: "Interstellar", vote_average: 8.6, poster_path: "/poster2.jpg", overview: "A space epic that explores the boundaries of science and human survival.")
            ],
            favoriteMovies: [],
            onMovieSelect: { _ in print("Selected movie") },
            onToggleFavorite: { _ in print("Toggled favorite") }
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
