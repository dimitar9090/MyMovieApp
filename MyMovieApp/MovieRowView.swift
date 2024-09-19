//
//  MovieRowView.swift
//  MyMovieApp
//
//  Created by Dimitar Angelov on 15.09.24.
//

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
            
            Spacer()
            
            Button(action: {
                onToggleFavorite(movie)
            }) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onMovieSelect(movie)
        }
    }
}
