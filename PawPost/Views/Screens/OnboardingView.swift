//
//  OnboardingView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 04/10/24.
//

import SwiftUI
import FirebaseAuth

struct OnboardingView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var showOnboardingPart2: Bool = false
    @State var showError: Bool = false
    @StateObject var vm = SignInWithGoogle()
    
    
    @State var displayName: String = ""
    @State var email: String = ""
    @State var providerId: String = ""
    @State var provider: String = ""
    
    //MARK: Functions
    func connectToFirebase(name: String, email: String, provider: String, credential: AuthCredential){
        
        AuthService.instance.loginUserToFirebase(credential: credential) { returnedProviderID, isError, isNewUser, returnedUserID in
            
            if let newUser = isNewUser {
                if newUser {
                    // newUser
                    if let providerId = returnedProviderID, !isError {
                        // success
                        
                        // new user, continue with onboarding view part 2
                        self.displayName = name
                        self.email = email
                        self.providerId = providerId
                        self.provider = provider
                        
                        self.showOnboardingPart2.toggle()
                    } else {
                        // error
                        print("error getting provider ID from login user to firebase")
                        self.showError.toggle()
                    }
                } else {
                    // existing user
                    if let userID = returnedUserID {
                        // success, login to app
                        AuthService.instance.loginUserToApp(userID: userID) { success in
                            if success {
                                print("Succesfully logged in existing user")
                                self.presentationMode.wrappedValue.dismiss()
                            } else {
                                print("Error logging in existing user into the app")
                                self.showError.toggle()
                            }
                        }
                        
                    } else {
                        // error
                        print("error getting provider ID from login user to firebase")
                        self.showError.toggle()
                    }
                }
            } else {
                // error
                print("error getting into from login user to firebase")
                self.showError.toggle()
            }
            
        }
    }
    
    
    //MARK: View
    var body: some View {
        VStack(spacing: 10){
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
                .shadow(radius: 12)
            
            Text("welcome to PawPost!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(Color.MyTheme.purpleColor)
            
            Text("Discover PawPost, the ultimate platform to showcase your pets' charm and connect with fellow animal enthusiasts. Share your furry friends' photos and spread the joy worldwide!")
                .font(.headline)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.MyTheme.purpleColor)
                .padding()
            
//            Button {
//                showOnboardingPart2.toggle()
//            } label: {
//                SignInWithAppleButtonCustom()
//                    .frame(height: 60)
//                    .frame(maxWidth: .infinity)
//            }
            
            Button {
                vm.signInWithGoogle(view: self)
                //                showOnboardingPart2.toggle()
            } label: {
                HStack {
                    Image(systemName: "globe")
                    
                    Text("Sign in with Google")
                }
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color(.sRGB, red: 222/255, green: 82/255, blue: 70/255, opacity: 1.0))
                .cornerRadius(5)
                .font(.system(size: 23, weight: .medium, design: .default))
            }
            .accentColor(Color.white)
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Continue as guest".uppercased())
                    .font(.headline)
                    .fontWeight(.medium)
                    .padding()
            }
            .accentColor(Color.black)
        }
        .padding(.all,20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.MyTheme.beigeColor)
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $showOnboardingPart2, onDismiss: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            OnboardingViewPart2(displayName: $displayName, email: $email, providerId: $providerId, provider: $provider)
        }
        .alert(isPresented: $showError) {
            return Alert(title: Text("Error signing in!"))
        }
        
    }
    
}

#Preview {
    OnboardingView()
}
