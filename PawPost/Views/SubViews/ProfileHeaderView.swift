//
//  ProfileHeaderView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 04/10/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    @Binding var profileDisplayName: String
    var body: some View {
        VStack(spacing: 10) {
            // MARK: Profile Image
            Image("dog1")
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120, alignment: .center)
                .clipShape(Circle())
            // MARK: Username
            Text(profileDisplayName)
                .font(.largeTitle)
                .fontWeight(.bold)
            // MARK: Bio
            Text("This is area where user can add a bio to their profile bla bla.")
                .font(.body)
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
            
            HStack(spacing: 20){
                // MARK: Posts
                VStack(spacing: 5){
                    Text("5")
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
                    Text("20")
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
    static var previews: some View {

        ProfileHeaderView(profileDisplayName: $name)
    }

}
