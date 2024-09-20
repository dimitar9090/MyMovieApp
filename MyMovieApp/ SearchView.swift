import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    var movies: [MovieModel]
    var favoriteMovies: [MovieModel]
    var onMovieSelect: (MovieModel) -> Void
    var onToggleFavorite: (MovieModel) -> Void
    
    var filteredMovies: [MovieModel] {
        if searchText.isEmpty {
            return []
        } else {
            return movies.filter { movie in
                movie.title.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        ZStack {
            // Background image for the search bar area
            if let firstMovie = filteredMovies.first, let posterPath = firstMovie.poster_path {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                } placeholder: {
                    Color.black // Placeholder while loading
                }
            } else {
                Color.black // Default background if no movies match the search
            }

            VStack {
                // Search bar
                TextField("Search for movies", text: $searchText)
                    .padding()
                    .background(Color.gray.opacity(0.7)) // Slightly transparent to see the background
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .foregroundColor(.white)

                // Movie list or no results message
                if !filteredMovies.isEmpty {
                    List(filteredMovies, id: \.id) { movie in
                        HStack {
                            // Movie poster
                            if let posterPath = movie.poster_path {
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 90) // Increased size
                                        .cornerRadius(8)
                                } placeholder: {
                                    Color.gray.frame(width: 60, height: 90).cornerRadius(8)
                                }
                            } else {
                                Color.gray.frame(width: 60, height: 90).cornerRadius(8)
                            }

                            VStack(alignment: .leading, spacing: 8) {
                                Text(movie.title)
                                    .font(.system(size: 18, weight: .bold)) // Increased font size for better readability
                                    .foregroundColor(.white)
                                    .lineLimit(2)

                                Text(String(format: "Rating: %.1f", movie.vote_average))
                                    .font(.system(size: 14)) // Slightly larger font size for the rating
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading) // Ensure the text fills the available space

                            // Favorite toggle button
                            Button(action: {
                                onToggleFavorite(movie)
                            }) {
                                Image(systemName: favoriteMovies.contains(where: { $0.id == movie.id }) ? "heart.fill" : "heart")
                                    .foregroundColor(favoriteMovies.contains(where: { $0.id == movie.id }) ? .red : .gray)
                                    .frame(width: 30, height: 30) // Make the button larger
                            }
                            .buttonStyle(PlainButtonStyle()) // Use plain button style to avoid default button styling
                            .padding(.trailing, 10) // Add some padding to the right of the heart icon
                        }
                        .listRowBackground(Color.black) // Background for the list row
                        .padding(.vertical, 5) // Space between rows
                        .onTapGesture {
                            onMovieSelect(movie)
                        }
                    }
                    .listStyle(PlainListStyle())
                } else {
                    Text("No results found")
                        .foregroundColor(.white)
                        .padding()
                }
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all)) // Background for the entire view
    }
}

// Preview
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(
            movies: [
                MovieModel(id: 1, title: "Inception", vote_average: 8.8, poster_path: "/poster1.jpg", overview: "A mind-bending thriller about dreams within dreams."),
                MovieModel(id: 2, title: "Interstellar", vote_average: 8.6, poster_path: "/poster2.jpg", overview: "A space epic that explores the boundaries of science and human survival.")
            ],
            favoriteMovies: [],
            onMovieSelect: { _ in print("Selected movie") },
            onToggleFavorite: { _ in print("Toggled favorite") }
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
