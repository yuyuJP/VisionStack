//
//  StackingView.swift
//  VisionStack
//
//  Created by Yusuke Asai on 2024/04/29.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct StackingView: View {
    @StateObject  var model = HandTrackingViewModel()
    
    var body: some View {
        RealityView { content in
            // add our content entity
            content.add(model.setupContentEntity())
        }.task {
            await model.runSession()
        }.task {
            // STEP1: Show hand updates
            await model.processHandUpdates()
        }.task {
            // STEP2: Place cubes with hand gestures
            // await model.processReconstructionUpdates()
        }.gesture(SpatialTapGesture().targetedToAnyEntity().onEnded({ value in
            
            Task {
                // STEP2: Place cubes with hand gestures
                // await model.placeCube()
            }
        }))
    }
}
