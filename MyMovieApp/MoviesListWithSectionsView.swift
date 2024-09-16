import SwiftUI

struct MoviesListWithSectionsView: View {
    var topRatedMovies: [MovieModel]
    var popularMovies: [MovieModel]
    var latestMovies: [MovieModel]
    var favoriteMovies: [MovieModel]
    var onMovieSelect: (MovieModel) -> Void
    var onToggleFavorite: (MovieModel) -> Void
    var onDeleteFavorite: (MovieModel) -> Void // Добавяме параметър за изтриване от любими
    
    @State private var isSearchActive = false
    @State private var isFavoritesActive = false // Състояние за показване на любими

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
                        isFavoritesActive = true // Активираме екрана с любими
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
                SearchView(
                    movies: topRatedMovies + popularMovies + latestMovies,
                    favoriteMovies: favoriteMovies, // Добавяме списъка с любими филми
                    onMovieSelect: onMovieSelect, // Добавяме action за избор на филм
                    onToggleFavorite: onToggleFavorite // Добавяме action за добавяне/премахване от любими
                )
            }
            .navigationDestination(isPresented: $isFavoritesActive) {
                FavoritesView(favoriteMovies: favoriteMovies, onMovieSelect: onMovieSelect, onDeleteFavorite: onDeleteFavorite) // Подаваме onDeleteFavorite
            }
        }
    }
}
