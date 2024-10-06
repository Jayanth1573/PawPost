//
//  SettingsEditTextView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 04/10/24.
//

import SwiftUI

struct SettingsEditTextView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var submissionText: String = ""
    @State var title: String
    @State var description: String
    @State var placeholder: String
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
    }
}

#Preview {
    NavigationStack{
        SettingsEditTextView(title: "Edit Display Name", description: "Description", placeholder: "placeholder")
    }
}
