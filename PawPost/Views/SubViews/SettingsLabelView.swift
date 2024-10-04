//
//  SettingsLabelView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 04/10/24.
//

import SwiftUI

struct SettingsLabelView: View {
    var labelText: String
    var labelImage: String
    var body: some View {
        VStack {
            HStack {
                Text(labelText)
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: labelImage)
            }
            Divider()
                .padding(.vertical, 4)
        }
    }
}

#Preview {
    SettingsLabelView(labelText: "Test Label", labelImage: "heart")
}
