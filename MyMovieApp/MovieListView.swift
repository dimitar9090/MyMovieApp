import SwiftUI

struct MovieListView: View {
    var movies: [MovieModel]
    var favoriteMovies: [MovieModel]
    var onMovieSelect: (MovieModel) -> Void
    var onToggleFavorite: (MovieModel) -> Void
    var onShowFavorites: () -> Void // Добавяме action за показване на любими
    
    @State private var isSearchActive = false // Състояние за активиране на търсене
    
    var body: some View {
        NavigationStack {
            List(movies, id: \.id) { movie in
                HStack {
                    Button(action: {
                        onMovieSelect(movie)
                    }) {
                        Text(movie.title)
                    }
                    
                    Spacer()
                    
                    // Бутон за добавяне/премахване от любими
                    Button(action: {
                        onToggleFavorite(movie)
                    }) {
                        Image(systemName: favoriteMovies.contains(where: { $0.id == movie.id }) ? "heart.fill" : "heart")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
            .navigationTitle("Movies")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    // Home button
                    Button(action: {
                        print("Home tapped")
                    }) {
                        Image(systemName: "house")
                    }
                    
                    Spacer()
                    
                    // Search button
                    Button(action: {
                        isSearchActive = true
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                    
                    Spacer()
                    
                    // Favorites button
                    Button(action: {
                        onShowFavorites() // Тук ще се показват любимите филми
                    }) {
                        Image(systemName: "heart.fill")
                    }
                    
                    Spacer()
                    
                    // Account button
                    Button(action: {
                        print("Account tapped")
                    }) {
                        Image(systemName: "person")
                    }
                }
            }
            .navigationDestination(isPresented: $isSearchActive) {
                SearchView(movies: movies)
            }
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(
            movies: [
                MovieModel(id: 1, title: "Inception", vote_average: 8.8, poster_path: nil, overview: "A mind-bending thriller about dreams within dreams."),
                MovieModel(id: 2, title: "Interstellar", vote_average: 8.6, poster_path: nil, overview: "A space epic that explores the boundaries of science and human survival.")
            ],
            favoriteMovies: [],
            onMovieSelect: { _ in },
            onToggleFavorite: { _ in },
            onShowFavorites: { }
        )
    }
}
