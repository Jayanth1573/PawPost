//
//  ContentView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 29/07/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage(CurrentUserDefaults.userID) var currentUserId: String?
    @AppStorage(CurrentUserDefaults.diplayName) var currentDisplayName: String?
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
                if let userID = currentUserId,let displayName = currentDisplayName {
                    NavigationStack {
                        ProfileView(isMyProfile: true, profileDisplayName: displayName, profileId: userID)
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
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        .accentColor(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
    }
}

#Preview {
    ContentView()
}
