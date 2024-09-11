import SwiftUI

struct MovieListView: View {
    var movies: [String]
    var onMovieSelect: (String) -> Void

    var body: some View {
        NavigationView {
            List(movies, id: \.self) { movie in
                Button(action: {
                    onMovieSelect(movie) // Извиква се при натискане на филм
                }) {
                    Text(movie)
                }
            }
            .navigationTitle("Movies")
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(movies: ["Inception", "Interstellar", "The Dark Knight"], onMovieSelect: { _ in })
    }
}
