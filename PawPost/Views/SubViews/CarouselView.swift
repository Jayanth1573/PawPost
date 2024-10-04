//
//  CarouselView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 02/08/24.
//

import SwiftUI

struct CarouselView: View {
    @State var selection: Int = 1
    @State var timerAdded: Bool = false
    let maxCount: Int = 8
    var body: some View {
        TabView(selection: $selection) {
            
            ForEach(1..<maxCount, id: \.self) { count in
                Image("dog\(count)")
                    .resizable()
                    .scaledToFill()
                    .tag(count)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 300)
        .animation(.default, value: selection)
        .onAppear(perform: {
            if !timerAdded {
                addTimer()
            }
           
        })
    }
    
    // MARK: Functions
    
    func addTimer() {
        timerAdded = true
        let timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { timer in
            if selection == (maxCount-1) {
                selection = 1
            } else {
                selection = selection + 1
            }
            
        }
        timer.fire()
    }
}

#Preview {
    CarouselView()
}
