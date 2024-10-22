//
//  Enums & Structs.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 10/10/24.
//

import Foundation

struct DatabaseUserField {
    
    static let displayName = "display_name"
    static let email = "email"
    static let providerID = "provider_id"
    static let provider = "provider"
    static let userID = "user_id"
    static let bio = "bio"
    static let dateCreated = "date_created"
    
}


struct DatabasePostField {
    static let postID = "post_id"
    static let userID = "user_id"
    static let displayName = "display_name"
    static let caption = "caption"
    static let dateCreated = "date_created"
    static let likeCount = "like_count" // Int
    static let likedBy = "liked_by" // Array
    static let comments = "comments" // sub collection
}

struct DatabaseCommentField {
    static let commentID = "comment_id"
    static let displayName = "display_name"
    static let userID = "user_id"
    static let content = "content"
    static let dateCreated = "date_created"
    
}

struct DatabaseReportField {
    static let postID = "post_id"
    static let content = "content"
    static let dateCreated = "date_created"
}

struct CurrentUserDefaults {
    static let displayName = "display_name"
    static let userID = "user_id"
    static let bio = "bio"
}

enum SettingsEditTextOption {
    case displayName
    case bio
}
