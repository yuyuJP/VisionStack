//
//  VisionStackApp.swift
//  VisionStack
//
//  Created by Yusuke Asai on 2024/04/29.
//

import SwiftUI

@main
struct VisionStackApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
        ImmersiveSpace(id: "StackingSpace") {
            StackingView()
        }
    }
}
