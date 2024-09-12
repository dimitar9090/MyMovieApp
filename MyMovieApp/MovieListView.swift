import SwiftUI

struct MovieListView: View {
    var movies: [Movie] // Променяме типа от [String] на [Movie]
    var onMovieSelect: (Movie) -> Void // Променяме типа на филма

    var body: some View {
        NavigationView {
            List(movies, id: \.title) { movie in // Използваме title като уникален идентификатор
                Button(action: {
                    onMovieSelect(movie) // Извиква се при натискане на филм
                }) {
                    Text(movie.title) // Показваме заглавието на филма
                }
            }
            .navigationTitle("Movies")
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(movies: [
            Movie(title: "Inception", overview: "A mind-bending thriller.", vote_average: 8.8, poster_path: nil),
            Movie(title: "Interstellar", overview: "A space exploration film.", vote_average: 8.6, poster_path: nil)
        ], onMovieSelect: { _ in })
    }
}
