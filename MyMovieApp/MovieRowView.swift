import SwiftUI

struct MovieRowView: View {
    var movie: MovieModel
    var isFavorite: Bool
    var onMovieSelect: (MovieModel) -> Void
    var onToggleFavorite: (MovieModel) -> Void
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path ?? "")")) { image in
                image
                    .resizable()
                    .frame(width: 50, height: 75)
                    .cornerRadius(8)
            } placeholder: {
                Color.gray.frame(width: 50, height: 75).cornerRadius(8)
            }
            
            Text(movie.title)
                .font(.headline)
                .lineLimit(2)
            
            Spacer()
            
            Button(action: {
                print("Toggle favorite for movie: \(movie.title)")
                onToggleFavorite(movie)
            }) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(isFavorite ? .red : .gray)
            }
            .buttonStyle(PlainButtonStyle()) // Осигуряване на стил на бутона без допълнителни стилове
        }
        .contentShape(Rectangle())
        .onTapGesture {
            print("Movie tapped: \(movie.title)")
            onMovieSelect(movie)
        }
    }
}

struct MovieRowView_Previews: PreviewProvider {
    static var previews: some View {
        MovieRowView(
            movie: MovieModel(id: 1, title: "Inception", vote_average: 8.8, poster_path: "/poster1.jpg", overview: "A mind-bending thriller about dreams within dreams."),
            isFavorite: true,
            onMovieSelect: { _ in print("Selected movie") },
            onToggleFavorite: { _ in print("Toggled favorite") }
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
