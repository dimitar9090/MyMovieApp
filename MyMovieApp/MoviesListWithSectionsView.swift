import SwiftUI

struct MoviesListWithSectionsView: View {
    var topRatedMovies: [MovieModel]
    var popularMovies: [MovieModel]
    var latestMovies: [MovieModel]
    var favoriteMovies: [MovieModel]
    var onMovieSelect: (MovieModel) -> Void
    var onToggleFavorite: (MovieModel) -> Void
    
    @State private var isSearchActive = false
    @State private var isFavoritesActive = false // New state for showing favorites

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
                        isFavoritesActive = true // Activate the favorites view
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
                SearchView(movies: topRatedMovies + popularMovies + latestMovies)
            }
            .navigationDestination(isPresented: $isFavoritesActive) {
                FavoritesView(favoriteMovies: favoriteMovies, onMovieSelect: onMovieSelect)
            }
        }
    }
}
