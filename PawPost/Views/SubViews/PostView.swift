//
//  PostView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 30/07/24.
//

import SwiftUI

struct PostView: View {
    @State var post: PostModel
    var showHeaderAndFooter: Bool
    
    @State var animateLike: Bool = false
    @State var addHeartAnimationToView: Bool
    
    @State var showActionSheet: Bool = false
    @State var actionSheetType: PostActionSheetOption = .general
    
    @State var profileImage: UIImage = UIImage(named: "logo.loading")!
    @State var postImage: UIImage = UIImage(named: "logo.loading")!
    
    // Alerts
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    @State var showAlert: Bool = false
    
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    enum PostActionSheetOption {
        case general
        case reporting
    }
    
    //MARK: Functions
    
    func likePost() {
        
        guard let userID = currentUserID else {
            print("Cannot find userID while liking the post.")
            return
        }
        // update the local data
        
        let updatedPost = PostModel(postId: post.postId, userId: post.userId, username: post.username, caption: post.caption, dateCreated: post.dateCreated, likeCount: post.likeCount + 1, likedByUser: true)
        self.post = updatedPost
        
        animateLike = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            animateLike = false
        }
        
        // update the database
        DataService.instance.likePost(postID: post.postId, currentUserID: userID)
    }
    
    func unLikePost() {
        
        guard let userID = currentUserID else {
            print("Cannot find userID while unliking the post.")
            return
        }
        
        let updatedPost = PostModel(postId: post.postId, userId: post.userId, username: post.username,caption: post.caption, dateCreated: post.dateCreated, likeCount: post.likeCount - 1, likedByUser: false)
        self.post = updatedPost
        
        // update the database
        DataService.instance.unlikePost(postID: post.postId, currentUserID: userID)
    }
    
    func getImages() {
        // get profile image
        ImageManager.instance.downloadProfileImage(userID: post.userId) { returnedImage in
            if let image = returnedImage {
                self.profileImage = image
            }
        }
        
        // get post image
        ImageManager.instance.downloadPostImage(postID: post.postId) { returnedImage in
            if let image = returnedImage {
                self.postImage = image
            }
        }
    }
    
    func getActionSheet() -> ActionSheet{
        
        switch self.actionSheetType {
        case .general:
            return ActionSheet(title: Text("What would you like to do?"), message: nil, buttons: [
                .destructive(Text("Report"), action: {
                    self.actionSheetType = .reporting
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        self.showActionSheet.toggle()
                    }
                }),
                .default(Text("Learn more..."), action: {
                    print("learn more pressed")
                }),
                .cancel()
            ])
        case .reporting:
            return ActionSheet(title: Text("Why are you reporting this post?"),message: nil, buttons: [
                .destructive(Text("This is inappropriate"), action: {
                    reportPost(reason: "This is inappropriate")
                }),
                .destructive(Text("This is spam"), action: {
                    reportPost(reason: "This is spam")
                }),
                .destructive(Text("It made me uncomfortable"), action: {
                    reportPost(reason: "It made me uncomfortable")
                }),
                .cancel({
                    self.actionSheetType = .general
                })
            ])
        }
        
    }
    
    func reportPost(reason: String) {
        print("Report Post Now")
        DataService.instance.uploadReport(reason: reason, postID: post.postId) { success in
            if success {
                self.alertTitle = "Reported!"
                self.alertMessage = "Thanks for reporting!, We will take appropriate action."
                self.showAlert.toggle()
            } else {
                self.alertTitle = "Error"
                self.alertMessage = "There was an error reporting post. Try again later."
                self.showAlert.toggle()
            }
        }
    }
    
    func sharePost() {
        let message = "Check out this post on PawPost!"
        let image = postImage
        // link that gets you back to your app, but we don't have access now so we use dummy link
        let link = URL(string: "https://www.google.com")!
        let activityViewController =  UIActivityViewController(activityItems: [message,image,link], applicationActivities: nil)
        
        // this was built in UIKit that runs on viewcontroller, which are kind of back board screen behind all these, we don't have access to background view controller
        // To get access:
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let viewController = windowScene.windows.first?.rootViewController
            viewController?.present(activityViewController, animated: true, completion: nil)
        }
        
        
    }
    
    //MARK: View
    var body: some View {
        VStack(alignment: .center, spacing: 0){
            // MARK: HEADER
            if showHeaderAndFooter {
                HStack {
                    
                    NavigationLink {
                        LazyView {
                            ProfileView(isMyProfile: false, profileDisplayName: post.username, profileId: post.userId, posts: PostArrayObject(userID: post.userId))
                            
                        }
                    } label: {
                        Image(uiImage: profileImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30,alignment: .center)
                            .cornerRadius(15)
                        
                        Text(post.username)
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.primary)
                    }
                    .accentColor(Color.primary)
                    
                    
                    Spacer()
                    
                    Button {
                        showActionSheet.toggle()
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.headline)
                    }
                    .accentColor(Color.primary)
                    //                    .confirmationDialog("What would you like to do?", isPresented: $showActionSheet, titleVisibility: .visible) {
                    //                        Button("Report", role: .destructive) {print("report post")}
                    //
                    //                        Button("Learn more...") {
                    //                            print("Learn more pressed")
                    //                        }
                    //
                    //                        Button("Cancel", role: .cancel) {}
                    //                    }
                    .actionSheet(isPresented: $showActionSheet) {
                        getActionSheet()
                    }
                    
                    
                }
                .padding(.all, 6)
            }
            
            // MARK: IMAGE
            ZStack {
                Image(uiImage: postImage)
                    .resizable()
                    .scaledToFit()
                    .onTapGesture(count: 2) {
                        if !post.likedByUser {
                            likePost()
                        }
                    }
                if addHeartAnimationToView {
                    LikeAnimationView(animate: $animateLike)
                }
                
            }
            
            // MARK: FOOTER
            
            if showHeaderAndFooter {
                HStack(alignment: .center, spacing: 20){
                    Button {
                        if post.likedByUser {
                            // unlike
                            unLikePost()
                        } else {
                            // like
                            likePost()
                        }
                    } label: {
                        Image(systemName: post.likedByUser ? "heart.fill" : "heart")
                            .font(.title3)
                    }
                    .accentColor(post.likedByUser ? .red : .primary)
                    
                    
                    // MARK: Comment icon
                    NavigationLink {
                        CommentsView(post: post)
                    } label: {
                        Image(systemName: "bubble.middle.bottom")
                            .font(.title3)
                    }
                    .accentColor(Color.primary)
                    
                    Button {
                        sharePost()
                    } label: {
                        Image(systemName: "paperplane")
                            .font(.title3)
                    }
                    .accentColor(Color.primary)
                    
                    Spacer()
                }
                .padding(.all, 6)
                
                if let caption = post.caption {
                    HStack {
                        Text(caption)
                        Spacer(minLength: 0)
                    }
                    .padding(.all, 6)
                }
            }
            
        }
        .onAppear {
            getImages()
        }
        .alert(isPresented: $showAlert) {
            return Alert(title: Text(alertTitle), message: Text(alertMessage),dismissButton: .default(Text("OK")))
        }

    }
}

struct PostView_Previews: PreviewProvider {
    static var post: PostModel = PostModel(postId: "", userId: "", username: "Jayanth", caption: "This is a caption", dateCreated: Date(), likeCount: 0, likedByUser: false)
    static var previews: some View {
        PostView(post: post, showHeaderAndFooter: true, addHeartAnimationToView: true)
    }
}
