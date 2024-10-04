//
//  ContentView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 29/07/24.
//

import SwiftUI

struct ContentView: View {
    var currentUserId: String? = nil
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
            
            UploadView()
                .tabItem {
                    Image(systemName: "square.and.arrow.up.fill")
                    Text("Upload")
                }
            
            ZStack {
                if currentUserId != nil {
                    NavigationStack {
                        ProfileView(isMyProfile: true, profileDisplayName: "My Profile", profileId: "")
                    }
                } else {
                    SignUpView()
                }
               
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
        }
        .onAppear(){
            UITabBar.appearance().backgroundColor = .white
        }
        .accentColor(Color.MyTheme.purpleColor)
    }
}

#Preview {
    ContentView()
}
