//
//  MainView.swift
//  MyMovieApp
//
//  Created by Dimitar Angelov on 13.09.24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            TabView {
                MovieListView() // Твоето MovieListView
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }

                SearchView() // Твоето SearchView
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }

                FavoritesView() // Placeholder за бъдещото FavoritesView
                    .tabItem {
                        Image(systemName: "heart")
                        Text("Favorites")
                    }

                ProfileView() // Placeholder за бъдещото ProfileView
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
