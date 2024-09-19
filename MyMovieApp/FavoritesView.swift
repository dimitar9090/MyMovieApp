import SwiftUI

struct FavoritesView: View {
    var favoriteMovies: [MovieModel]
    var onMovieSelect: (MovieModel) -> Void
    var onDeleteFavorite: (MovieModel) -> Void

    var body: some View {
        List(favoriteMovies, id: \.id) { movie in
            HStack {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path ?? "")")) { image in
                    image
                        .resizable()
                        .frame(width: 50, height: 75)
                        .cornerRadius(8)
                } placeholder: {
                    Color.gray.frame(width: 50, height: 75).cornerRadius(8)
                }
                
                Text(movie.title)
                    .font(.headline)
                    .lineLimit(2)
                
                Spacer()
                
                Button(action: {
                    onDeleteFavorite(movie)
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
            .onTapGesture {
                onMovieSelect(movie)
            }
        }
        .navigationTitle("Favorite Movies")
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(
            favoriteMovies: [
                MovieModel(id: 1, title: "Inception", vote_average: 8.8, poster_path: "/poster1.jpg", overview: "A mind-bending thriller about dreams within dreams."),
                MovieModel(id: 2, title: "Interstellar", vote_average: 8.6, poster_path: "/poster2.jpg", overview: "A space epic that explores the boundaries of science and human survival.")
            ],
            onMovieSelect: { _ in print("Selected movie") },
            onDeleteFavorite: { _ in print("Deleted from favorites") }
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
