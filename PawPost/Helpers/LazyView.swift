//
//  LazyView.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 12/10/24.
//

import Foundation
import SwiftUI

struct LazyView<content: View>: View {
    var content: () -> content
    var body: some View {
        self.content()
    }
}
