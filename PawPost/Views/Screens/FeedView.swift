//
//  FeedView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 30/07/24.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var posts: PostArrayObject
    var title: String
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(posts.dataArray, id: \.self){ post in
                    PostView(post: post, showHeaderAndFooter: true, addHeartAnimationToView: true)
                }
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FeedView(posts: PostArrayObject(shuffled: false), title: "Home test")
        }
    }

}
