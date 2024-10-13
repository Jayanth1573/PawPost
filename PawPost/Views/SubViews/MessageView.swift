//
//  MessageView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 30/07/24.
//

import SwiftUI

struct MessageView: View {
    @State var comment: CommentModel
    @State var profilePicture: UIImage = UIImage(named: "logo.loading")!
    
    //MARK: Functions
    
    func getProfilePicture() {
        ImageManager.instance.downloadProfileImage(userID: comment.userId) { returnedImage in
            if let image = returnedImage {
                self.profilePicture = image
            }
        }
    }
    
    // MARK: View
    var body: some View {
        HStack {
            
            // MARK: Profile image
            Image(uiImage: profilePicture)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 4) {
                
                // MARK: Username
                Text(comment.username)
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                // MARK: Content
                Text(comment.content)
                    .padding(.all, 10)
                    .foregroundStyle(.primary)
                    .background(Color.gray)
                    .cornerRadius(10)

            }
            Spacer(minLength: 0)
        }
        .onAppear {
            getProfilePicture()
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var comment: CommentModel = CommentModel(commentId: "", userId: "", username: "Jayanth", content: "This is a comment ", dateCreated: Date())

    static var previews: some View {
        MessageView(comment: comment)
    }
}
