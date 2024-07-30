//
//  CommentModel.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 30/07/24.
//

import Foundation
import SwiftUI

struct CommentModel: Identifiable, Hashable {
    var id = UUID()
    var commentId: String
    var userId: String
    var username: String
    var content: String
    var dateCreated: Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
