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
    @State var profileBio: String = ""
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
    
    func getAdditionalProfileInfo() {
        AuthService.instance.getUserInfo(forUserID: profileId) { ReturnedDisplayName, returnedBio in
            if let displayName = ReturnedDisplayName {
                self.profileDisplayName = displayName
            }
            
            if let bio = returnedBio {
                self.profileBio = bio
            }
        }
    }
    // MARK: View
    var body: some View {
        ScrollView(content: {
            ProfileHeaderView(profileDisplayName: $profileDisplayName, profileImage: $profileImage, postArray: posts, profileBio: $profileBio)
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
            getAdditionalProfileInfo()
        }
        .sheet(isPresented: $showSettings) {
            SettingsView(userDisplayName: $profileDisplayName, userBio: $profileBio, userProfilePicture: $profileImage)
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
