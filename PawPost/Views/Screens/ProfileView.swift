//
//  ProfileView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 04/10/24.
//

import SwiftUI

struct ProfileView: View {
    var isMyProfile: Bool
    @State var profileDisplayName: String
    var profileId: String
    var posts = PostArrayObject()
    @State var showSettings: Bool = false
    
    var body: some View {
        ScrollView(content: {
            ProfileHeaderView(profileDisplayName: $profileDisplayName)
            Divider()
            ImageGridView(posts: posts)
        })
        
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    showSettings.toggle()
                    }, label: {
                        Image(systemName: "line.horizontal.3")
                    })
                    .accentColor(Color.MyTheme.purpleColor)
                    .opacity(isMyProfile ? 1.0 : 0.0)
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
//        .fullScreenCover(isPresented: $showSettings) {
//            SettingsView()
//        }
    }
}

#Preview {
    NavigationStack {
        ProfileView(isMyProfile: true, profileDisplayName: "Jayanth", profileId: "")
    }
    
}
