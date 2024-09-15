//
//  FavoritesView.swift
//  MyMovieApp
//
//  Created by Dimitar Angelov on 15.09.24.
//

import SwiftUI

struct FavoritesView: View {
    var favoriteMovies: [MovieModel]
    
    var body: some View {
        NavigationStack {
            if favoriteMovies.isEmpty {
                Text("No favorite movies yet.")
                    .foregroundColor(.gray)
                    .font(.headline)
            } else {
                List(favoriteMovies, id: \.id) { movie in
                    Text(movie.title)
                }
                .navigationTitle("Favorites")
            }
        }
    }
}
struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        // Примерни данни за преглед
        let sampleMovies = [
            MovieModel(id: 1, title: "Inception", vote_average: 8.8, poster_path: "/poster1.jpg", overview: "A mind-bending thriller."),
            MovieModel(id: 2, title: "The Matrix", vote_average: 8.7, poster_path: "/poster2.jpg", overview: "A dystopian future."),
            MovieModel(id: 3, title: "Interstellar", vote_average: 8.6, poster_path: "/poster3.jpg", overview: "A journey through space.")
        ]
        
        FavoritesView(favoriteMovies: sampleMovies)
    }
}
