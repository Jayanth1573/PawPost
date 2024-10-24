//
//  PostArrayObject.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 30/07/24.
//

import Foundation

class PostArrayObject: ObservableObject {
    @Published var dataArray = [PostModel]()
    @Published var postCountString = "0"
    @Published var likesCountString = "0"
    
    /// Used for single post selection
    init(post: PostModel) {
        self.dataArray.append(post)
    }
    
    /// Used for getting posts for user profile
    init(userID: String) {
        print("get posts for userID: \(userID)")
        DataService.instance.downloadPostForUser(userID: userID) { returnedPosts in
            let sortedPosts = returnedPosts.sorted { post1, post2 in
                return post1.dateCreated > post2.dateCreated
            }
            self.dataArray.append(contentsOf: sortedPosts)
            self.updateCounts()
        }
    }
    
    /// used for feed
    init(shuffled: Bool){
        print("get posts for feed shuffled: \(shuffled)")
        DataService.instance.downloadPostForFeed { returnedPosts in
            if shuffled {
                let shuffledPosts = returnedPosts.shuffled()
                self.dataArray.append(contentsOf: shuffledPosts)
            } else {
                self.dataArray.append(contentsOf: returnedPosts)
            }
        }
    }
    
    func updateCounts() {
        // post count
        self.postCountString = "\(self.dataArray.count)"
        
        // like count
        let likeCountArray = dataArray.map { existingPost in
            return existingPost.likeCount
        }
        let sumOfLikeCountArray = likeCountArray.reduce(0, +)
        print(sumOfLikeCountArray)
        self.likesCountString = "\(sumOfLikeCountArray)"
        
        
        
    }
}
