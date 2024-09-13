import SwiftUI

struct MovieDetailView: View {
    var movieTitle: String
    var movieDescription: String
    var movieRating: Double
    var moviePosterURL: String

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(movieTitle)
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(movieDescription)
                .font(.body)
                .foregroundColor(.gray)
            
            Text("Rating: \(movieRating, specifier: "%.1f")/10")
                .font(.subheadline)
                .foregroundColor(.blue)
            
            AsyncImage(url: URL(string: moviePosterURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 200, height: 300)

            Spacer()
        }
        .padding()
        .navigationTitle("Details")
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(
            movieTitle: "Inception",
            movieDescription: "A mind-bending thriller about dreams within dreams.",
            movieRating: 8.8,
            moviePosterURL: "https://image.tmdb.org/t/p/w500//posterPathExample.jpg"
        )
    }
}
