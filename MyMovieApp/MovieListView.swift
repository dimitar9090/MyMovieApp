import SwiftUI

struct MovieListView: View {
    @State private var searchText = ""
    var movies: [MovieModel] // Използваме MovieModel вместо String
    var onMovieSelect: (MovieModel) -> Void
    
    // Филтриране на филмите по търсене
    var filteredMovies: [MovieModel] {
        if searchText.isEmpty {
            return movies
        } else {
            return movies.filter { movie in
                movie.title.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredMovies, id: \.id) { movie in
                Button(action: {
                    onMovieSelect(movie) // Извиква се при натискане на филм
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
                        print("Search tapped")
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
            .searchable(text: $searchText, prompt: "Search for movies or actors") // Добавяме търсачката тук
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(
            movies: [MovieModel(id: 1, title: "Inception", vote_average: 8.8, poster_path: nil)],
            onMovieSelect: { _ in }
        )
    }
}
