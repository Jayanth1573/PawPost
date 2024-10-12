//
//  BrowseView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 02/08/24.
//

import SwiftUI

struct BrowseView: View {
    var posts: PostArrayObject
    var body: some View {
        ScrollView {
            CarouselView()
            ImageGridView(posts: posts)
        }
        .navigationTitle("Browse")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

#Preview {
    NavigationStack {
        BrowseView(posts: PostArrayObject(shuffled: true))
    }
    
}
