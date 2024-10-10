//
//  SignInWithGoogle.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 08/10/24.
//

import Foundation
import SwiftUI
import GoogleSignIn
import Firebase

class SignInWithGoogle: ObservableObject {
    var onboardingView: OnboardingView!
    
    func signInWithGoogle(view: OnboardingView) {
        self.onboardingView = view
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: Application_utility.rootViewController){ user, error in
            
            if let error = error {
                print(error.localizedDescription)
                self.onboardingView.showError.toggle()
                return
            }
            
            guard let user = user?.user,
                  let fullName = user.profile?.name,
                  let email = user.profile?.email,
                  let idToken = user.idToken else { return }
            
            print("fullname: \(fullName), email: \(email)")
            
            let accessToken = user.accessToken
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            
            self.onboardingView.connectToFirebase(name: fullName, email: email, provider: "google", credential: credential)
            
            Auth.auth().signIn(with: credential){ res, error in
                if let error = error {
                    print(error.localizedDescription)
                    self.onboardingView.showError.toggle()
                    return
                }
                
                guard let user = res?.user else { return }
                print(user)
            }
            
        }
    }
}

