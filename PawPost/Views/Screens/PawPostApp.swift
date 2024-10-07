//
//  PawPostApp.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 29/07/24.
//

import SwiftUI
import FirebaseCore

@main
struct PawPostApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
