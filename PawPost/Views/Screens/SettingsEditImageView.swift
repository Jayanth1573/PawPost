//
//  SettingsEditImageView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 04/10/24.
//

import SwiftUI
import UIKit

struct SettingsEditImageView: View {

    @State var title: String
    @State var description: String
    @State var selectedImage: UIImage
    @State var showImagePicker: Bool = false
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    
    @State var showSuccessAlert: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var profileImage: UIImage
    
    let haptics = UINotificationFeedbackGenerator()

    // MARK: Functions
    
    func saveImage() {
        guard let userID = currentUserID else {return}
        
        // Update UI of the profile
        self.profileImage = selectedImage
        
        // update profile image in database
        ImageManager.instance.uploadProfileImage(userID: userID, image: selectedImage)
        
        self.showSuccessAlert.toggle()
        
    }
    
    func dismissView() {
        haptics.notificationOccurred(.success)
        self.presentationMode.wrappedValue.dismiss()
    }
    
    // MARK: View
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text(description)
                Spacer(minLength: 0)
            }
            Image(uiImage: selectedImage)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200, alignment: .center)
                .clipped()
                .cornerRadius(12)
            
            Button {
                showImagePicker.toggle()
            } label: {
                Text("Import" .uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.yellowColor)
                    .cornerRadius(12)
            }
            .accentColor(Color.MyTheme.purpleColor)
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(imageSelected: $selectedImage, sourceType: $sourceType)
            }
            
            Button {
                saveImage()
            } label: {
                Text("Save" .uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.purpleColor)
                    .cornerRadius(12)
            }
            .accentColor(Color.MyTheme.yellowColor)          
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .navigationTitle(title)
        .alert(isPresented: $showSuccessAlert) {
            return Alert(title: Text("Saved"),dismissButton: .default(Text("OK"), action: {
                dismissView()
            }))
        }
    }

}


struct SettingsEditImageView_Previews: PreviewProvider {
    @State static var image: UIImage = UIImage(named: "dog1")!
    static var previews: some View {
        NavigationStack {
            SettingsEditImageView(title: "Edit Profile Picture", description: "Edit your profile picture", selectedImage: UIImage(named: "dog1")!, profileImage: $image)
        }
    }

}


