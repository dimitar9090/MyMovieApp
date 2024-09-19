import SwiftUI

struct MoviesListWithSectionsView: View {
    var topRatedMovies: [MovieModel]
    var popularMovies: [MovieModel]
    var latestMovies: [MovieModel]
    var favoriteMovies: [MovieModel]
    var onMovieSelect: (MovieModel) -> Void
    var onToggleFavorite: (MovieModel) -> Void
    var onDeleteFavorite: (MovieModel) -> Void
    
    @State private var isSearchActive = false
    @State private var isFavoritesActive = false

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Top Rated")) {
                    ForEach(topRatedMovies, id: \.id) { movie in
                        MovieRowView(movie: movie, isFavorite: favoriteMovies.contains(where: { $0.id == movie.id }),
                                     onMovieSelect: onMovieSelect, onToggleFavorite: onToggleFavorite)
                    }
                }
                
                Section(header: Text("Popular")) {
                    ForEach(popularMovies, id: \.id) { movie in
                        MovieRowView(movie: movie, isFavorite: favoriteMovies.contains(where: { $0.id == movie.id }),
                                     onMovieSelect: onMovieSelect, onToggleFavorite: onToggleFavorite)
                    }
                }
                
                Section(header: Text("Latest")) {
                    ForEach(latestMovies, id: \.id) { movie in
                        MovieRowView(movie: movie, isFavorite: favoriteMovies.contains(where: { $0.id == movie.id }),
                                     onMovieSelect: onMovieSelect, onToggleFavorite: onToggleFavorite)
                    }
                }
            }
            .navigationTitle("Movies")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {
                        print("Home tapped")
                    }) {
                        Image(systemName: "house")
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        isSearchActive = true
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        isFavoritesActive = true
                    }) {
                        Image(systemName: "heart.fill")
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        print("Account tapped")
                    }) {
                        Image(systemName: "person")
                    }
                }
            }
            .navigationDestination(isPresented: $isSearchActive) {
                SearchView(
                    movies: topRatedMovies + popularMovies + latestMovies,
                    favoriteMovies: favoriteMovies,
                    onMovieSelect: onMovieSelect,
                    onToggleFavorite: onToggleFavorite
                )
            }
            .navigationDestination(isPresented: $isFavoritesActive) {
                FavoritesView(favoriteMovies: favoriteMovies, onMovieSelect: onMovieSelect, onDeleteFavorite: onDeleteFavorite)
            }
        }
    }
}
