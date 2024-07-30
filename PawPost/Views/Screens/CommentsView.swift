//
//  CommentsView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 30/07/24.
//

import SwiftUI

struct CommentsView: View {
    @State var submissionText: String = ""
    @State var commentArray = [CommentModel]()
    
    // MARK: Functions
    func getComments() {
        print("get comments from database.")
        let comment1 = CommentModel(commentId: "", userId: "", username: "Jayanth", content: "hehe no comments", dateCreated: Date())
        let comment2 = CommentModel(commentId: "", userId: "", username: "Utkarsh", content: "Main toh UP se hoon aur main chor hoon", dateCreated: Date())
        let comment3 = CommentModel(commentId: "", userId: "", username: "Shantanu", content: "Shantanu is gay, and he is proud to be a gay ", dateCreated: Date())
        let comment4 = CommentModel(commentId: "", userId: "", username: "Shreyansh", content: "Mujhe kya main toh chibi hoon.", dateCreated: Date())
        
        self.commentArray.append(comment1)
        self.commentArray.append(comment2)
        self.commentArray.append(comment3)
        self.commentArray.append(comment4)
    }
    
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
                Image("dog1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(20)
                TextField("Add a comment here...", text: $submissionText)
                Button(action: {
                    
                }, label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)
                        .accentColor(Color.MyTheme.purpleColor)
                })
            }
            .padding(.all,6)
        }
        .navigationTitle("Comments")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            getComments()
            
        })
    }
}

#Preview {
    NavigationStack {
        CommentsView()
    }
    
}
