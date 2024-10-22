//
//  ProfileHeaderView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 04/10/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    @Binding var profileDisplayName: String
    @Binding var profileImage: UIImage
    @ObservedObject var postArray: PostArrayObject
    @Binding var profileBio: String
    var body: some View {
        VStack(spacing: 10) {
            // MARK: Profile Image
            Image(uiImage: profileImage)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120, alignment: .center)
                .clipShape(Circle())
            // MARK: Username
            Text(profileDisplayName)
                .font(.largeTitle)
                .fontWeight(.bold)
            // MARK: Bio
            if profileBio != "" {
                Text(profileBio)
                    .font(.body)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
            }
            
            
            HStack(spacing: 20){
                // MARK: Posts
                VStack(spacing: 5){
                    Text(postArray.postCountString)
                        .font(.title2)
                        .fontWeight(.bold)
                    Capsule()
                        .fill(Color.gray)
                        .frame(width: 20, height: 2, alignment: .center)
                    Text("Posts")
                        .font(.callout)
                        .fontWeight(.medium)
                }
                
                // MARK: Likes
                VStack(spacing: 5){
                    Text(postArray.likesCountString)
                        .font(.title2)
                        .fontWeight(.bold)
                    Capsule()
                        .fill(Color.gray)
                        .frame(width: 20, height: 2, alignment: .center)
                    Text("Likes")
                        .font(.callout)
                        .fontWeight(.medium)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    @State static var name: String = "Jayanth"
    @State static var image: UIImage = UIImage(named: "dog1")!
    @State static var bio: String = "Demo bio"
    static var previews: some View {
        
        ProfileHeaderView(profileDisplayName: $name, profileImage: $image, postArray: PostArrayObject(shuffled: false), profileBio: $bio)
    }
    
}
