//
//  SettingsView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 04/10/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: Functions
    func openCustonURL(urlstring: String) {
        guard let url = URL(string: urlstring) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
            
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // MARK: Section 1: PawPost
                GroupBox {
                    HStack(spacing: 10) {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80,height: 80, alignment: .center)
                            .cornerRadius(12)
                        
                        Text("Discover PawPost, the ultimate platform to showcase your pets' charm and connect with fellow animal enthusiasts. Share your furry friends' photos and spread the joy worldwide!")
                    }
                } label: {
                    SettingsLabelView(labelText: "PawPost", labelImage: "dot.radiowaves.left.and.right")
                }
                .padding()

                // MARK: Section 2: Profile
                GroupBox {
                    NavigationLink {
                        SettingsEditTextView(submissionText: "Current Display Name", title: "Display Name", description: "You can edit your display name here. This will be seen by other users on your profile and on your posts!", placeholder: "Your display name here...")
                    } label: {
                        SettingsRowView(leftIcon: "pencil", text: "Display name", color: Color.MyTheme.purpleColor)
                    }

                    NavigationLink {
                        SettingsEditTextView(submissionText: "Current Bio here", title: "Profile Bio", description: "Your bio is a great place to let other users know a little about you. It will be seen on your profile.", placeholder: "Your bio here...")
                    } label: {
                        SettingsRowView(leftIcon: "text.quote", text: "Bio", color: Color.MyTheme.purpleColor)
                    }
                    
                    NavigationLink {
                        SettingsEditImageView(title: "Profile Picture", description: "Your profile picture will be shown on your posts.", selectedImage: UIImage(named: "dog1")!)
                    } label: {
                        SettingsRowView(leftIcon: "photo", text: "Profile Picture", color: Color.MyTheme.purpleColor)
                    }

                    
                    
                    SettingsRowView(leftIcon: "figure.walk", text: "Sign out", color: Color.MyTheme.purpleColor)
                } label: {
                    SettingsLabelView(labelText: "Profile", labelImage: "person.fill")
                }
                .padding()
                
                //MARK: Section 3: Application
                GroupBox {
                    
                    Button {
                        openCustonURL(urlstring: "https://www.google.com")
                    } label: {
                        SettingsRowView(leftIcon: "folder.fill", text: "Privacy Policy", color: Color.MyTheme.yellowColor)
                    }

                    
                    Button {
                        openCustonURL(urlstring: "https://www.yahoo.com")
                    } label: {
                        SettingsRowView(leftIcon: "folder.fill", text: "Terms and Conditions", color: Color.MyTheme.yellowColor)
                    }
                    
                    Button {
                        openCustonURL(urlstring: "https://www.bing.com")
                    } label: {
                        SettingsRowView(leftIcon: "globe", text: "PawPost's website", color: Color.MyTheme.yellowColor)
                    }
                    
                } label: {
                    SettingsLabelView(labelText: "Application", labelImage: "apps.iphone")
                }
                .padding()
                
                // MARK: Section 4: Sign off
                
                GroupBox {
                    Text(" PawPost was made with love. \n All Rights Reserved \n Jayanth Ramdas Ambaldhage \n Copyright 2024 ❤️")
                        .foregroundStyle(Color.gray)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .padding(.bottom,80)


            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title)
                    }
                    .accentColor(.primary)

                }
                
            }
        }
    }
}

#Preview {
    SettingsView()
}
