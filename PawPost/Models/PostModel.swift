//
//  PostModel.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 30/07/24.
//

import Foundation
import SwiftUI

struct PostModel: Identifiable, Hashable {
    var id = UUID()
    var postId: String
    var userId: String
    var username: String
    var caption: String?
    var dateCreated: Date
    var likeCount: Int
    var likedByUser: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
