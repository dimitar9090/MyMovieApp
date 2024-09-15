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
            Button(action: {
                onMovieSelect(movie)
            }) {
                Text(movie.title)
                    .font(.headline)
            }

            Spacer()

            Button(action: {
                onToggleFavorite(movie)
            }) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(isFavorite ? .red : .gray)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .padding()
    }
}

struct MovieRowView_Previews: PreviewProvider {
    static var previews: some View {
        MovieRowView(
            movie: MovieModel(id: 1, title: "Inception", vote_average: 8.8, poster_path: "/poster1.jpg", overview: "A mind-bending thriller."),
            isFavorite: true,
            onMovieSelect: { _ in },
            onToggleFavorite: { _ in }
        )
    }
}
