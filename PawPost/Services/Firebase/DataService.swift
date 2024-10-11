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
    
    // MARK: Functions
    
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
    
}
