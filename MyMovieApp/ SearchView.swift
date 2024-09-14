import SwiftUI

struct SearchView: View {
    @State private var searchText = "" // Текущ текст в полето за търсене
    var movies: [MovieModel] // Списък с филми
    
    // Избиране на произволен филм за фон
    var randomMovie: MovieModel? {
        movies.randomElement()
    }
    
    // Филтриране на филмите според търсене
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
        NavigationView {
            ZStack {
                // Показваме произволен постер като фон
                if let posterPath = randomMovie?.poster_path {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .opacity(0.4)
                            .ignoresSafeArea()
                    } placeholder: {
                        Color.black.opacity(0.1)
                    }
                }
                
                VStack {
                    // Потребителски TextField за търсене
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                        TextField("Search for movies", text: $searchText)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.black.opacity(0.3))
                            .cornerRadius(8)
                    }
                    .padding()
                    
                    // Ако има резултати от търсене, показваме списъка, иначе съобщение
                    if !filteredMovies.isEmpty {
                        List(filteredMovies, id: \.id) { movie in
                            Text(movie.title)
                                .foregroundColor(.black) // Текстът е черен за контраст с фона
                        }
                    }
                }
            }
            
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(movies: [
            MovieModel(id: 1, title: "Inception", vote_average: 8.8, poster_path: "/poster1.jpg", overview: "A mind-bending thriller about dreams within dreams."),
            MovieModel(id: 2, title: "Interstellar", vote_average: 8.6, poster_path: "/poster2.jpg", overview: "A space epic that explores the boundaries of science and human survival.")
        ])
    }
}
