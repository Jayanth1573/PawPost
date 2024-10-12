//
//  DataService.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 11/10/24.
//

import Foundation
import SwiftUI
import FirebaseFirestore

class DataService {
    // MARK: Properties
    static let instance = DataService()
    private var REF_POSTS = DB_BASE.collection("posts")
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    
    // MARK: Create Functions
    
    func uploadPost(image: UIImage, caption: String?, displayName: String, userID: String, handler: @escaping(_ success: Bool) -> ()) {
        
        // create new post document
        let document = REF_POSTS.document()
        let postID = document.documentID
        
        // upload image to storage
        ImageManager.instance.uploadPostImage(postID: postID, image: image) { success in
            if success {
                // successfully uploaded image data to storage
                // now upload post data to database
                let postData: [String : Any] = [
                    DatabasePostField.postID : postID,
                    DatabasePostField.userID : userID,
                    DatabasePostField.displayName : displayName,
                    DatabasePostField.caption : caption,
                    DatabasePostField.dateCreated : FieldValue.serverTimestamp()
                ]
                document.setData(postData) { error in
                    if let error = error {
                        print("Error uploading data to post document: \(error)")
                        handler(false)
                        return
                    } else {
                        // return back to app
                        handler(true)
                        return
                    }
                }
            } else {
                print("Error uploading post image into firebase")
                handler(false)
                return
            }
        }
    }
    
    // MARK: Get functions
    
    func downloadPostForUser(userID: String, handler: @escaping (_ posts: [PostModel]) -> ()){
        REF_POSTS.whereField(DatabasePostField.userID, isEqualTo: userID).getDocuments { querySnapshot, error in
            handler(self.getPostsFromSnapshot(querySnapshot: querySnapshot))
        }
    }
    
    func downloadPostForFeed(handler: @escaping (_ posts: [PostModel])->()){
        REF_POSTS.order(by: DatabasePostField.dateCreated, descending: true).limit(to: 50).getDocuments { querySnapshot, error in
            handler(self.getPostsFromSnapshot(querySnapshot: querySnapshot))
        }
    }
    
    private func getPostsFromSnapshot(querySnapshot: QuerySnapshot?) -> [PostModel] {
        var postArray = [PostModel]()
        if let snapshot = querySnapshot, snapshot.documents.count > 0 {
            
            for document in snapshot.documents {
                let postID = document.documentID
                
                if
                    let userID = document.get(DatabasePostField.userID) as? String,
                    let displayName = document.get(DatabasePostField.displayName) as? String,
                    let timeStamp = document.get(DatabasePostField.dateCreated) as? Timestamp {
                    
                    let caption = document.get(DatabasePostField.caption) as? String
                    let date = timeStamp.dateValue()
                    
                    let likeCount = document.get(DatabasePostField.likeCount) as? Int ?? 0
                    var likedByUser: Bool = false
                    if let userIDArray = document.get(DatabasePostField.likedBy) as? [String], let userID = currentUserID {
                        likedByUser = userIDArray.contains(userID)
                    }
                    
                    let newPost = PostModel(postId: postID, userId: userID, username: displayName,caption: caption, dateCreated: date, likeCount: 0, likedByUser: likedByUser)
                    
                    postArray.append(newPost)
                }
            }
            return postArray
        } else {
            print("No documents in snapshot found for this user.")
            return postArray
        }
    }
    
    // MARK: Update functions
    
    func likePost(postID: String, currentUserID: String){
        
        let increament: Int64 = 1
        let data: [String : Any] = [
            DatabasePostField.likeCount: FieldValue.increment(increament),
            DatabasePostField.likedBy: FieldValue.arrayUnion([currentUserID])
        ]
        REF_POSTS.document(postID).updateData(data)
    }
    
    func unlikePost(postID: String, currentUserID: String){
        
        let increament: Int64 = -1
        let data: [String : Any] = [
            DatabasePostField.likeCount: FieldValue.increment(increament),
            DatabasePostField.likedBy: FieldValue.arrayRemove([currentUserID])
        ]
        REF_POSTS.document(postID).updateData(data)
    }
}
