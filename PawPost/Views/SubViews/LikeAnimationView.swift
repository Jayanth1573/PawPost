//
//  LikeAnimationView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 04/10/24.
//

import SwiftUI

struct LikeAnimationView: View {
    @Binding var animate: Bool
    var body: some View {
        ZStack {
            Image(systemName: "heart.fill")
                .foregroundStyle(Color.red.opacity(0.3))
                .font(.system(size: 200))
                .opacity(animate ? 1.0 : 0.0)
                .scaleEffect(animate ? 1.0 : 0.3)
            
            Image(systemName: "heart.fill")
                .foregroundStyle(Color.red.opacity(0.6))
                .font(.system(size: 150))
                .opacity(animate ? 1.0 : 0.0)
                .scaleEffect(animate ? 1.0 : 0.4)
            
            Image(systemName: "heart.fill")
                .foregroundStyle(Color.red.opacity(0.9))
                .font(.system(size: 100))
                .opacity(animate ? 1.0 : 0.0)
                .scaleEffect(animate ? 1.0 : 0.5)
        }
        .animation(Animation.easeInOut(duration: 0.5), value: animate)

    }
}

struct LikeAnimationView_Previews: PreviewProvider {
    @State static var animate: Bool = false
    static var previews: some View {
        LikeAnimationView(animate: $animate)
    }

}

