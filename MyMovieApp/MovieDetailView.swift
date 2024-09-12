import SwiftUI

struct MovieDetailView: View {
    var movieTitle: String
    var movieDescription: String
    var movieRating: Double
    var moviePosterURL: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(movieTitle)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                if let url = URL(string: moviePosterURL) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 450)
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                Text("Rating: \(String(format: "%.1f", movieRating))/10")
                    .font(.headline)
                
                Text(movieDescription)
                    .font(.body)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Details")
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(
            movieTitle: "Inception",
            movieDescription: "A mind-bending thriller about dreams within dreams.",
            movieRating: 8.8,
            moviePosterURL: "https://image.tmdb.org/t/p/w500/cIh6OhWjEP49vOkj7HEXXISdhe3.jpg"
        )
    }
}
