//
//  ProfileView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 04/10/24.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.colorScheme) var colorScheme
    var isMyProfile: Bool
    @State var profileDisplayName: String
    var profileId: String
    var posts: PostArrayObject
    @State var showSettings: Bool = false
    
    @State var profileImage: UIImage = UIImage(named: "logo.loading")!
    
    
    // MARK: Functions
    
    func getProfileImage() {
        ImageManager.instance.downloadProfileImage(userID: profileId) { returnedImage in
            if let image = returnedImage {
                profileImage = image
            }
        }
    }
    // MARK: View
    var body: some View {
        ScrollView(content: {
            ProfileHeaderView(profileDisplayName: $profileDisplayName, profileImage: $profileImage)
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
                .accentColor(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
                    .opacity(isMyProfile ? 1.0 : 0.0)
            }
            
        }
        .onAppear {
            getProfileImage()
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
        ProfileView(isMyProfile: true, profileDisplayName: "Jayanth", profileId: "", posts: PostArrayObject(userID: ""))
    }
    
}
