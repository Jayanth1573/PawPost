//
//  FeedView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 30/07/24.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var posts: PostArrayObject
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(posts.dataArray, id: \.self){ post in
                    PostView(post: post)
                }
            }
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FeedView(posts: PostArrayObject())
        }
    }

}
