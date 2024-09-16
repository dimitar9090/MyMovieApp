import SwiftUI

struct SearchView: View {
    @State private var searchText = "" // Текущ текст в полето за търсене
    var movies: [MovieModel] // Списък с филми
    var favoriteMovies: [MovieModel] // Любими филми
    var onMovieSelect: (MovieModel) -> Void // Избиране на филм за показване на DetailView
    var onToggleFavorite: (MovieModel) -> Void // Добавяне/премахване на филм от любими
    
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
                            .opacity(0.4) // Леко намален фон
                            .ignoresSafeArea()
                    } placeholder: {
                        Color.black.opacity(0.1)
                    }
                }
                
                VStack {
                    // Потребителски TextField за търсене
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white) // По-светла икона
                        TextField("Search for movies", text: $searchText)
                            .foregroundColor(.white) // По-светъл текст
                            .font(.system(size: 18, weight: .bold)) // Увеличен и по-смел шрифт
                            .padding(12)
                            .background(Color.black.opacity(0.5)) // Запазваме по-лек фон, без да е твърде тъмен
                            .cornerRadius(12)
                    }
                    .padding()
                    
                    // Ако има резултати от търсене, показваме списъка
                    if !filteredMovies.isEmpty {
                        List(filteredMovies, id: \.id) { movie in
                            HStack {
                                Button(action: {
                                    onMovieSelect(movie) // Извикваме DetailView за избрания филм
                                }) {
                                    Text(movie.title)
                                        .foregroundColor(.black) // Текстът е черен за контраст с фона
                                }
                                
                                Spacer()
                                
                                // Бутон за добавяне/премахване от любими
                                Button(action: {
                                    onToggleFavorite(movie) // Добавяне/премахване на филм от любими
                                }) {
                                    Image(systemName: favoriteMovies.contains(where: { $0.id == movie.id }) ? "heart.fill" : "heart")
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                        }
                    } else {
                        Text("No results found")
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(
            movies: [
                MovieModel(id: 1, title: "Inception", vote_average: 8.8, poster_path: "/poster1.jpg", overview: "A mind-bending thriller about dreams within dreams."),
                MovieModel(id: 2, title: "Interstellar", vote_average: 8.6, poster_path: "/poster2.jpg", overview: "A space epic that explores the boundaries of science and human survival.")
            ],
            favoriteMovies: [],
            onMovieSelect: { _ in },
            onToggleFavorite: { _ in }
        )
    }
}
