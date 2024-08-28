//
//  LandingTaskView.swift
//  AdaptiveInfoAssistant
//
//  Created by Jerry Wang on 2024/8/27.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct LandingTaskView: View {
    @Binding var isManual: Bool
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .frame(depth: -100)
//                .frame(width: 640, height:  360)
            previewCardTests(isManual: $isManual)
                .frame(depth: 200)
        }
//        RealityView { content in
//            do {
//                let lunarAnchor = try await Entity.load(named: "LunarEnvironment", in: realityKitContentBundle)
//                content.add(lunarAnchor)
//            } catch {
//                print("Failed to load the Lunar environment: \(error)")
//            }
//        }
    }
}

#Preview {
}
