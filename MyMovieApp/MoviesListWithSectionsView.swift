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
            // Navigating to the Search View when search is active
            .navigationDestination(isPresented: $isSearchActive) {
                SearchView(movies: topRatedMovies + popularMovies + latestMovies)
            }
            // Navigating to the Favorites View when favorites is active
            .navigationDestination(isPresented: $isFavoritesActive) {
                FavoritesView(favoriteMovies: favoriteMovies) // Show the list of favorite movies
            }
        }
    }
}

// MovieRowView to handle individual rows in the movie sections
struct MovieRowView: View {
    var movie: MovieModel
    var isFavorite: Bool
    var onMovieSelect: (MovieModel) -> Void
    var onToggleFavorite: (MovieModel) -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                onMovieSelect(movie)
            }) {
                Text(movie.title)
            }
            
            Spacer()
            
            Button(action: {
                onToggleFavorite(movie)
            }) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}


