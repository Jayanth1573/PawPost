//
//  PostArrayObject.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 30/07/24.
//

import Foundation

class PostArrayObject: ObservableObject {
    @Published var dataArray = [PostModel]()
    
    init() {
        print("Fetch from database here")
        let post1 = PostModel(postId: "", userId: "", username: "Jayanth",caption: "This is caption", dateCreated: Date(), likeCount: 0, likedByUser: false)
        let post2 = PostModel(postId: "", userId: "", username: "Utkarsh",caption: nil, dateCreated: Date(), likeCount: 0, likedByUser: false)
        let post3 = PostModel(postId: "", userId: "", username: "Shantanu",caption: "This is a long long long long bla bla bla bla bla bla bla caption", dateCreated: Date(), likeCount: 0, likedByUser: false)
        let post4 = PostModel(postId: "", userId: "", username: "Shreyansh",caption: "This is caption", dateCreated: Date(), likeCount: 0, likedByUser: false)
        
        self.dataArray.append(post1)
        self.dataArray.append(post2)
        self.dataArray.append(post3)
        self.dataArray.append(post4)
    }
}
