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
//    @Binding var isManual: Bool
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .frame(depth: -100)
//                .frame(width: 640, height:  360)
            previewCardTests()
                .frame(depth: 200)
        }
    }
}

// Information item model to represent each information component
struct InfoItem {
    let item: String
    let priority: String
}

// Abstract function that generates a view based on item and priority
@ViewBuilder
func generateView(item: String, priority: String) -> some View {
    switch (item, priority) {
    case ("hSpeed", "medium"):
        gaugeMediumView(item: "hSpeed")
            .glassBackgroundEffect()
    case ("vSpeed", "medium"):
        gaugeMediumView(item: "vSpeed")
            .glassBackgroundEffect()
    case ("attitude", "medium"):
        attitudeMediumView().glassBackgroundEffect()
    case ("fuel", "medium"):
        gaugeMediumView(item: "fuel")
            .glassBackgroundEffect()
    case ("height", "medium"):
        gaugeMediumView(item: "height")
            .glassBackgroundEffect()
    case ("topographic3D", "medium"):
        topographic3DMediumView().glassBackgroundEffect()
    case ("camera", "medium"):
        cameraMediumView(isShowingAssistMark: .constant(false))
            .glassBackgroundEffect()
    default:
        EmptyView()
    }
}

// LeftPanel View with dynamic child component generation based on infoItems array
struct LeftPanel: View {
    var infoItems: [InfoItem]  // Array of information items
    @EnvironmentObject var model: InfoModel

    var body: some View {
        VStack {
            ForEach(infoItems, id: \.item) { info in
                generateView(item: info.item, priority: info.priority)
            }
        }
        .transition(.slide)
        .onAppear {
            model.startUpdating()
        }
        .onDisappear {
            model.stopUpdating()
        }
    }
}

// RightPanel View with dynamic child component generation based on infoItems array
struct RightPanel: View {
    var infoItems: [InfoItem]  // Array of information items
    @EnvironmentObject var model: InfoModel

    var body: some View {
        VStack {
            ForEach(infoItems, id: \.item) { info in
                generateView(item: info.item, priority: info.priority)
                    .frame(width: 400, height: 300)
            }
        }
        .transition(.move(edge: .trailing))
    }
}

// Refactored previewCardTests View
struct previewCardTests: View {
    @State var selectedInfo: String = "speed"
    @State private var showAlert = false
    @StateObject var model = InfoModel()
    
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    
    // Arrays of information items for left and right panels
    let leftPanelInfoItems: [InfoItem] = [
        InfoItem(item: "hSpeed", priority: "medium"),
        InfoItem(item: "vSpeed", priority: "medium"),
        InfoItem(item: "attitude", priority: "medium"),
//        InfoItem(item: "fuel", priority: "medium"),
//        InfoItem(item: "height", priority: "medium")
    ]
    
    let rightPanelInfoItems: [InfoItem] = [
        InfoItem(item: "camera", priority: "medium"),
        InfoItem(item: "topographic3D", priority: "medium")
    ]
    
    var body: some View {
        HStack {
            LeftPanel(infoItems: leftPanelInfoItems)
                .environmentObject(model)
            Spacer()
            RightPanel(infoItems: rightPanelInfoItems)
                .environmentObject(model)
        }
        .animation(.easeInOut, value: showAlert)
        .ornament(attachmentAnchor: .scene(.bottom)) {
            HStack(spacing: 10) {
                IconButton(imageName: "location", selectedInfo: $selectedInfo)
                IconButton(imageName: "graduated scale", selectedInfo: $selectedInfo)
                IconButton(imageName: "scale", selectedInfo: $selectedInfo)
                IconButton(imageName: "trajectory", selectedInfo: $selectedInfo)
                IconButton(imageName: "tips", selectedInfo: $selectedInfo)
            }
            .padding()
            .glassBackgroundEffect()
            Text("已折叠信息项")
                .foregroundStyle(.secondary)
                .font(.system(size: 20, weight: .bold))
        }
        .onChange(of: showAlert) {
            if showAlert {
                openWindow(id: "cameraDetailedView")
            }
        }
    }
}

#Preview {
    previewCardTests()
}
