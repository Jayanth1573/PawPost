//
//  PostView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 30/07/24.
//

import SwiftUI

struct PostView: View {
    @State var post: PostModel
    var showHeaderAndFooter: Bool
    
    var body: some View {
        VStack{
            
            // MARK: HEADER
            if showHeaderAndFooter {
                HStack {
                    
                    NavigationLink {
                        ProfileView(isMyProfile: false, profileDisplayName: post.username, profileId: post.userId)
                    } label: {
                        Image("dog1")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30,alignment: .center)
                            .cornerRadius(15)
                        
                        Text(post.username)
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.primary)
                    }

                    
                    
                    Spacer()
                    
                    Image(systemName: "ellipsis")
                        .font(.headline)
                }
                .padding(.all, 6)
            }
           
            // MARK: IMAGE
            Image("dog1")
                .resizable()
                .scaledToFit()
            
            // MARK: FOOTER
            
            if showHeaderAndFooter {
                HStack(alignment: .center, spacing: 20){
                    Image(systemName: "heart")
                        .font(.title3)
                    NavigationLink {
                        CommentsView()
                    } label: {
                        Image(systemName: "bubble.middle.bottom")
                            .font(.title3)
                            .foregroundStyle(.primary)
                    }
                    
                    Image(systemName: "paperplane")
                        .font(.title3)
                    
                    Spacer()
                }
                .padding(.all, 6)
                
                if let caption = post.caption {
                    HStack {
                        Text(caption)
                        Spacer(minLength: 0)
                    }
                    .padding(.all, 6)
                }
            }

        }
        
    }
}

struct PostView_Previews: PreviewProvider {
    static var post: PostModel = PostModel(postId: "", userId: "", username: "Jayanth", caption: "This is a caption", dateCreated: Date(), likeCount: 0, likedByUser: false)
    static var previews: some View {
        PostView(post: post, showHeaderAndFooter: true)
    }
}
