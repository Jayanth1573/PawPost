//
//  PostImageView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 05/09/24.
//

import SwiftUI

struct PostImageView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var captionText: String = ""
    @Binding var imageSelected: UIImage
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                        .font(.title)
                        .padding()
                })
                .accentColor(.primary)
                
                Spacer()
            }
            ScrollView{
                Image(uiImage: imageSelected)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200, alignment: .center)
                    .cornerRadius(12)
                    .clipped()
                
                TextField("Add your caption here", text: $captionText)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.beigeColor)
                    .cornerRadius(12)
                    .font(.headline)
                    .padding(.horizontal)
                    .textInputAutocapitalization(.sentences)
                
                Button(action: {
                    postPicture()
                }, label: {
                    Text("Post a picture!").textCase(.uppercase)
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding()
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(Color.MyTheme.purpleColor)
                        .cornerRadius(12)
                        .padding(.horizontal)
                })
                .accentColor(Color.MyTheme.yellowColor)
            }
        }
    }
    
    // MARK: Functions
    
    func postPicture() {
        print("Post picture to database")
    }
}

struct postImageView_Previews: PreviewProvider {
    
    
    @State static var image = UIImage(named: "dog1")!
    
    static var previews: some View {
        PostImageView(imageSelected: $image)
    }
    
}
