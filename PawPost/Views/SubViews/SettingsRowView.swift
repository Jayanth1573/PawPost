//
//  SettingsRowView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 04/10/24.
//

import SwiftUI

struct SettingsRowView: View {
    
    var leftIcon: String
    var text: String
    var color: Color
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color)
                Image(systemName: leftIcon)
                    .font(.title3)
                    .foregroundStyle(Color.white)
            }
            .frame(width: 36, height: 36, alignment: .center)
            
            Text(text)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding(.vertical,4)
    }
}

//#Preview {
//    SettingsRowView()
//        
//}

struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowView(leftIcon: "heart.fill", text: "Row title", color: .red)
            .previewLayout(.sizeThatFits)
    }

}
