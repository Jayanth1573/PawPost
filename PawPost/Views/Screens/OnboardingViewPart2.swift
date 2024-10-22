//
//  OnboardingViewPart2.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 04/10/24.
//

import SwiftUI

struct OnboardingViewPart2: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    @Binding var displayName: String
    @Binding var email: String
    @Binding var providerId: String
    @Binding var provider: String
    
    @State var showImagePicker: Bool = false
    @State var imageSelected: UIImage = UIImage(named: "logo")!
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @State var showError: Bool = false
    
    // MARK: Functions
    
    func createProfile() {
        AuthService.instance.createNewUserInDatabase(name: displayName, email: email, providerID: providerId, provider: provider, profileImage: imageSelected) { returnedUserID in
            
            if let userID = returnedUserID {
                // success
                print("Successfully created new user in database!")
                AuthService.instance.loginUserToApp(userID: userID, handler: { success in
                    if success {
                        print("user logged in successfully")
//                        return to app
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6){
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        
                    } else {
                        print("Error logging in")
                        self.showError.toggle()
                    }
                })
            } else {
                // error
                print("Error creating user in database")
                self.showError.toggle()
            }
            
        }
    }
    
    // MARK: View
    var body: some View {
        VStack(alignment: .center,spacing: 20) {
            Text("What's your name")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color.MyTheme.yellowColor)
            
            TextField("", text: $displayName, prompt: Text("Add your name here...").foregroundColor(Color.gray))
                .foregroundStyle(Color.black)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.MyTheme.beigeColor)
                .cornerRadius(12)
                .font(.headline)
                .textInputAutocapitalization(.sentences)
                .padding(.horizontal)
    
            Button {
                showImagePicker.toggle()
            } label: {
                Text("Add profile picture")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.yellowColor)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            .accentColor(Color.MyTheme.purpleColor)
            .opacity(displayName != "" ? 1.0 : 0.0)
            .animation(.easeOut(duration: 1.0), value: displayName)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.MyTheme.purpleColor)
        .edgesIgnoringSafeArea(.all)
        
        .sheet(isPresented: $showImagePicker) {
            createProfile()
        } content: {
            ImagePicker(imageSelected: $imageSelected, sourceType: $sourceType)
                .accentColor(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
        }
        .alert(isPresented: $showError) {
            return Alert(title: Text("Error creating profile!"))
        }

    }
}

struct OnboardingViewPart2_Previews: PreviewProvider {
    @State static var testString: String = "test"
    static var previews: some View {
        
        OnboardingViewPart2(displayName: $testString, email: $testString, providerId: $testString, provider: $testString)
     
    }

}
