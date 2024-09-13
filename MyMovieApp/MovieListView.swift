import SwiftUI

struct MovieListView: View {
    @State private var isSearchActive = false // Състояние за активиране на търсене
    var movies: [MovieModel]
    var onMovieSelect: (MovieModel) -> Void
    
    var body: some View {
        NavigationStack {
            List(movies, id: \.id) { movie in
                Button(action: {
                    onMovieSelect(movie)
                }) {
                    Text(movie.title)
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
                        print("Favorites tapped")
                    }) {
                        Image(systemName: "heart")
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
            // Преминаване към SearchView при активиране на isSearchActive
            .navigationDestination(isPresented: $isSearchActive) {
                SearchView(movies: movies)
            }
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(movies: [
            MovieModel(id: 1, title: "Inception", vote_average: 8.8, poster_path: nil),
            MovieModel(id: 2, title: "Interstellar", vote_average: 8.6, poster_path: nil)
        ], onMovieSelect: { _ in })
    }
}
