import SwiftUI

struct FavoritesView: View {
    var favoriteMovies: [MovieModel]
    var onMovieSelect: (MovieModel) -> Void
    var onDeleteFavorite: (MovieModel) -> Void

    var body: some View {
        List(favoriteMovies, id: \.id) { movie in
            HStack {
                Text(movie.title)
                Spacer()
                Button(action: {
                    onDeleteFavorite(movie)
                }) {
                    Image(systemName: "trash")
                }
            }
            .onTapGesture {
                onMovieSelect(movie)
            }
        }
        .navigationTitle("Favorite Movies")
    }
}
