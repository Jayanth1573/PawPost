//
//  ImageGridView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 03/08/24.
//

import SwiftUI

struct ImageGridView: View {
    @ObservedObject var posts: PostArrayObject
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
        ], content: {
            ForEach(posts.dataArray, id: \.self) { post in
                NavigationLink {
                    FeedView(posts: PostArrayObject(post: post), title: "Post")
                } label: {
                    PostView(post: post, showHeaderAndFooter: false, addHeartAnimationToView: false)
                }

            }
            
        })
    }
}

#Preview {
    ImageGridView(posts: PostArrayObject())
}
