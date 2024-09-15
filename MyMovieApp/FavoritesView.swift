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
