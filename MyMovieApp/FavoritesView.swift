import SwiftUI

struct FavoritesView: View {
    @State var favoriteMovies: [MovieModel]
    var onMovieSelect: (MovieModel) -> Void
    var onDeleteFavorite: (MovieModel) -> Void // Action за изтриване на филм от любими
    
    var body: some View {
        NavigationStack {
            if favoriteMovies.isEmpty {
                Text("No favorite movies yet.")
                    .foregroundColor(.gray)
                    .font(.headline)
            } else {
                List {
                    ForEach(favoriteMovies, id: \.id) { movie in
                        MovieRowView(
                            movie: movie,
                            isFavorite: true,
                            onMovieSelect: onMovieSelect,
                            onToggleFavorite: { _ in } // Не използваме тук
                        )
                    }
                    .onDelete(perform: deleteMovie)
                }
                .navigationTitle("Favorites")
            }
        }
    }
    
    // Функция за изтриване на филм от списъка
    func deleteMovie(at offsets: IndexSet) {
        offsets.forEach { index in
            let movie = favoriteMovies[index]
            onDeleteFavorite(movie) // Извиква се action-а за изтриване
        }
        favoriteMovies.remove(atOffsets: offsets)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        // Примерни данни за преглед
        let sampleMovies = [
            MovieModel(id: 1, title: "Inception", vote_average: 8.8, poster_path: "/poster1.jpg", overview: "A mind-bending thriller."),
            MovieModel(id: 2, title: "The Matrix", vote_average: 8.7, poster_path: "/poster2.jpg", overview: "A dystopian future."),
            MovieModel(id: 3, title: "Interstellar", vote_average: 8.6, poster_path: "/poster3.jpg", overview: "A journey through space.")
        ]
        
        FavoritesView(favoriteMovies: sampleMovies, onMovieSelect: { _ in }, onDeleteFavorite: { _ in })
    }
}
