//
//  ContentView.swift
//  VisionStack
//
//  Created by Yusuke Asai on 2024/04/29.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    @State var showImmversiveSpace = false
    
    var body: some View {
        GeometryReader { proxy in
            let textWidth = min(max(proxy.size.width * 0.4, 300), 500)
            ZStack {
                HStack(spacing: 60) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Vision Stack")
                            .font(.system(size: 50, weight: .bold))
                            .padding(.bottom, 15)
                        Text("To start stacking cubes, click on the 'Start Stacking'")
                            .padding(.bottom, 30)
                            .accessibilitySortPriority(3)
                        
                        Toggle(showImmversiveSpace ? "Stop Stacking": "Start Stacking", isOn: $showImmversiveSpace)
                            .onChange(of: showImmversiveSpace) { _, isShowing in
                                Task {
                                    if isShowing {
                                        await openImmersiveSpace(id: "StackingSpace")
                                    } else {
                                        await dismissImmersiveSpace()
                                    }
                                }
                            }
                            .toggleStyle(.button)
                    }
                    .frame(width: textWidth, alignment: .leading)
                    .padding()
                    
                    Color.clear
                        .overlay{
                            SampleModel(orientation: [-0.3, 0.4, 0])
                                .dragRotation(yawLimit: .degrees(45),
                                              pitchLimit: .degrees(45))
                                .frame(height: 200)
                                .frame(depth: 200)
                                .offset(z: 250)
                        }
                    
                }
                .padding()
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
