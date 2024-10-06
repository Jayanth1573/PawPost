//
//  UploadView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 03/08/24.
//

import SwiftUI
import UIKit
struct UploadView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var showImagePicker: Bool = false
    @State var imageSelected: UIImage = UIImage(named: "logo")!
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var showPostImageView: Bool = false
    var body: some View {
        
        ZStack {
            VStack {
                Button(action: {
                    sourceType = UIImagePickerController.SourceType.camera
                    showImagePicker.toggle()
                },label: {
                    Text("Take Photo".uppercased())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.MyTheme.yellowColor)
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(Color.MyTheme.purpleColor)
                
                Button(action: {
                    sourceType = UIImagePickerController.SourceType.photoLibrary
                    showImagePicker.toggle()
                },label: {
                    Text("Import Photo".uppercased())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.MyTheme.purpleColor)
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(Color.MyTheme.yellowColor)
            }
//            .edgesIgnoringSafeArea(.top)
            .sheet(isPresented: $showImagePicker, onDismiss: segueToPostImageView, content: {
                ImagePicker(imageSelected: $imageSelected, sourceType: $sourceType)
                    .accentColor(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
            })

            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150, alignment: .center)
                .shadow(radius: 12)
            
                .fullScreenCover(isPresented: $showPostImageView, content: {
                    PostImageView(imageSelected: $imageSelected)
                    
                })
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    //MARK: Functions
    
    func segueToPostImageView() {
        
        // adding delay
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            showPostImageView.toggle()
        }
       
    }
}

#Preview {
    UploadView()
}
