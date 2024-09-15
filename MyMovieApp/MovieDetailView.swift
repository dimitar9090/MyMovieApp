import SwiftUI

struct MovieDetailView: View {
    var movie: MovieModel

    var body: some View {
        VStack {
            Text(movie.title)
                .font(.largeTitle)
                .padding()

            if let posterPath = movie.poster_path {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500" + posterPath)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView() // Показваме индикатор на зареждане, докато изображението се зарежда
                }
                .padding()
            } else {
                Image(systemName: "photo") // Дефолтна икона, ако няма изображение
                    .padding()
            }

            Text("Rating: \(movie.vote_average, specifier: "%.1f")")
                .padding()

            if let overview = movie.overview {
                Text(overview)
                    .padding()
            }

            Spacer()
        }
        .navigationTitle("Movie Details")
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: MovieModel(id: 1, title: "Inception", vote_average: 8.8, poster_path: "/poster1.jpg", overview: "A mind-bending thriller about dreams within dreams."))
    }
}
