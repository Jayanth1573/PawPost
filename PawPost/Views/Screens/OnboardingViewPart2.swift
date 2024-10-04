//
//  OnboardingViewPart2.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 04/10/24.
//

import SwiftUI

struct OnboardingViewPart2: View {
    @State var displayName: String = ""
    @State var showImagePicker: Bool = false
    
    
    @State var imageSelected: UIImage = UIImage(named: "logo")!
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    // MARK: Functions
    func createProfile() {
        print("create profile now")
    }
    var body: some View {
        VStack(alignment: .center,spacing: 20) {
            Text("What's your name")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color.MyTheme.yellowColor)
            
            TextField("Add your name here...", text: $displayName)
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
        }

    }
}

#Preview {
    OnboardingViewPart2()
}
