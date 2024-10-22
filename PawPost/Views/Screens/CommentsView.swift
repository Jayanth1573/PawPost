//
//  CommentsView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 30/07/24.
//

import SwiftUI

struct CommentsView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var submissionText: String = ""
    @State var commentArray = [CommentModel]()
    
    @State var profilePicture: UIImage = UIImage(named: "logo.loading")!
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    @AppStorage(CurrentUserDefaults.displayName) var currentDisplayName: String?
    
    var post: PostModel
    
    // MARK: Functions
    func getComments() {
        guard self.commentArray.isEmpty else {return}
        print("get comments from database.")
        if let caption = post.caption, caption.count > 1 {
            let captionComment = CommentModel(commentId: "", userId: post.userId, username: post.username, content: caption, dateCreated: post.dateCreated)
            self.commentArray.append(captionComment)
        }
        DataService.instance.downloadComments(postID: post.postId) { returnedComments in
            self.commentArray.append(contentsOf: returnedComments)
        }
    }
    
    func getProfilePicture() {
        guard let userID = currentUserID else { return }
        ImageManager.instance.downloadProfileImage(userID: userID) { returnedImage in
            if let image = returnedImage {
                self.profilePicture = image
            }
        }
    }
    
    func textIsAppropriate() -> Bool {
        if submissionText.count < 2 {
            return false
        }
        return true
    }
    
    func addComment() {
        guard let userID = currentUserID, let displayName = currentDisplayName else {
            return
        }
        DataService.instance.uploadComment(postID: post.postId, content: submissionText, displayName: displayName, userID: userID) { success, returnedCommentID in
            
            if success, let commentID = returnedCommentID {
                let newComment = CommentModel(commentId: commentID, userId: userID, username: displayName, content: submissionText, dateCreated: Date())
                self.commentArray.append(newComment)
                self.submissionText = ""
                // dismiss the keyboard
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
    
    // MARK: View
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(commentArray, id: \.self) { comment in
                        MessageView(comment: comment)
                    }
                }
            }
            HStack {
                Image(uiImage: profilePicture)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(20)
                TextField("Add a comment here...", text: $submissionText)
                Button(action: {
                    if textIsAppropriate() {
                        addComment()
                    }
                }, label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)
                        .accentColor(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
                })
                
            }
            .padding(.all,6)
        }
        .padding(.horizontal,6)
        .navigationTitle("Comments")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            getComments()
            getProfilePicture()
        })
    }
}

struct CommentsView_Previews: PreviewProvider {
    static let post = PostModel(postId: "", userId: "", username: "Jayanth", dateCreated: Date(), likeCount: 0, likedByUser: false)
    static var previews: some View {
        NavigationStack {
            CommentsView(post: post)
        }
    }

}
