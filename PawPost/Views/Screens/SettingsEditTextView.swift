//
//  SettingsEditTextView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 04/10/24.
//

import SwiftUI



struct SettingsEditTextView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @State var submissionText: String = ""
    @State var title: String
    @State var description: String
    @State var placeholder: String
    @State var settingsEditTextOption: SettingsEditTextOption
    @Binding var profileText: String
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    @State var showSuccessAlert: Bool = false
    
    let haptics = UINotificationFeedbackGenerator()
    
    // MARK: Functions
    
    func textIsAppropriate() -> Bool {
        
        if submissionText.count < 1 {
            return false
        }
        return true
    }
    
    func saveText() {
        
        guard let userID = currentUserID else {return}
        switch settingsEditTextOption {
        case .displayName:
            
            // update the name on UI
            self.profileText = submissionText
            
            // update the name in user defaults
            UserDefaults.standard.set(submissionText, forKey: CurrentUserDefaults.displayName)
            
            // update on all the user's posts
            DataService.instance.updateDisplayNameOnPosts(userID: userID, displayName: submissionText)
            
            // update on the user's profile in DB
            AuthService.instance.updateUserDisplayName(userID: userID, displayName: submissionText) { success in
                if success {
                    self.showSuccessAlert.toggle()
                }
            }
        case .bio:
            // update the name on UI
            self.profileText = submissionText
            
            // update the name in user defaults
            UserDefaults.standard.set(submissionText, forKey: CurrentUserDefaults.bio)
            
            // update on the user's profile in DB
            AuthService.instance.updateUserBio(userID: userID, bio: submissionText) { success in
                if success {
                    self.showSuccessAlert.toggle()
                }
            }
            
        }
    }
    
    func dismissView() {
        haptics.notificationOccurred(.success)
        self.presentationMode.wrappedValue.dismiss()
    }
    
    // MARK: View
    var body: some View {
        VStack {
            HStack {
                Text(description)
                Spacer(minLength: 0)
            }
            
            TextField(placeholder, text: $submissionText)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(colorScheme == .light ? Color.MyTheme.beigeColor : Color.MyTheme.purpleColor)
                .cornerRadius(12)
                .font(.headline)
                .textInputAutocapitalization(.sentences)
            
            Button {
                if textIsAppropriate() {
                    saveText()
                }
            } label: {
                Text("Save" .uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
                    .cornerRadius(12)
            }
            .accentColor(colorScheme == .light ? Color.MyTheme.yellowColor : Color.MyTheme.purpleColor)
            

            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .navigationTitle(title)
        .alert(isPresented: $showSuccessAlert) {
            return Alert(title: Text("Saved!"), dismissButton: .default(Text("OK"), action: {
                dismissView()
            }))
        }
    }
}


struct SettingsEditTextView_Previews: PreviewProvider {
    @State static var text: String = ""
    static var previews: some View {
        NavigationStack {
            SettingsEditTextView(title: "Edit Display Name", description: "Description", placeholder: "placeholder", settingsEditTextOption: .displayName, profileText: $text)
        }
    }

}

