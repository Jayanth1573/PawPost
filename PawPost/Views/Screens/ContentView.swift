//
//  ContentView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 29/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack{
                FeedView(posts: PostArrayObject(), title: "Home")
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            NavigationStack {
                BrowseView()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Browse")
            }
            Text("Screen 3")
                .tabItem {
                    Image(systemName: "square.and.arrow.up.fill")
                    Text("Upload")
                }
            Text("Screen 4")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .accentColor(Color.MyTheme.purpleColor)
    }
}

#Preview {
    ContentView()
}
