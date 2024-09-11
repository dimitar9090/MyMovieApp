//
//  MovieDetailView.swift
//  MyMovieApp
//
//  Created by Dimitar Angelov on 11.09.24.
//

import SwiftUI

struct MovieDetailView: View {
    var movieTitle: String
    var movieDescription: String

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(movieTitle)
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(movieDescription)
                .font(.body)
                .foregroundColor(.gray)

            Spacer()
        }
        .padding()
        .navigationTitle("Details")
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movieTitle: "Inception", movieDescription: "A mind-bending thriller about dreams within dreams.")
    }
}
