//
//  detailedViews.swift
//  AdaptiveInfoAssistant
//
//  Created by Jerry Wang on 2024/8/27.
//

import SwiftUI

struct LunarSurfaceView: View {
    var body: some View {
        Image("moonSurface")  // Replace "lunar_surface" with the actual name of your image asset
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct cameraDetailedView: View {
    var title: String = "系统检测到光学图像显示地形异常！建议切换至半自动或手动模式。"
    var titleIcon: String = "hand.point.up"
    @State private var selectedInfo: String = "speed"
    @State var landingMode: String = "auto"
    
    @Binding var isManual: Bool
    var body: some View {
        VStack{
            HStack {
                if (landingMode == "auto"){
                    Label(title, systemImage: "exclamationmark.circle")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.red)
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(30)
                } else if (landingMode == "manual"){
                    Label("手控模式", systemImage: "hand.point.up")
                        .font(.system(size: 24, weight: .bold))
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(30)
                } else {
                    Label("光学图像", systemImage: "camera")
                        .font(.system(size: 24, weight: .bold))
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(30)
                }
                Spacer()
                Button(action: {
                    // Action for first button
                }) {
                    Image("markings")
                }
                .buttonStyle(PlainButtonStyle())
                Button(action: {
                    // Action for first button
                }) {
                    Image("displayMarker")
                }
                .padding(.trailing)
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.top)
            .padding(.horizontal)
            
            ZStack {
                Image("moonSurface2")
                    .resizable()
                    .cornerRadius(30)
                    .padding(.bottom)
                    .padding(.horizontal)
                if (landingMode == "manual") {
                    Image("supporting information")
                        .frame(depth: 100)
                }
                else{
                    Image("landingArea")
                        .resizable()
                }
            }
        }.ornament(attachmentAnchor: .scene(.bottom)){
            HStack(spacing: 10) {
                Picker("Select Layout", selection: $landingMode) {
                    Text("自动模式").tag("auto")
                    Text("半自控模式").tag("semiAuto")
                    Text("手控模式").tag("manual")
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding()
            .glassBackgroundEffect()
            Text("已折叠信息项").foregroundStyle(.secondary).font(.system(size: 20, weight: .bold))
        }
        .ornament(attachmentAnchor: .scene(.leading)){
            VStack(spacing: 10) {
                IconButton(imageName: "adding area", selectedInfo: $selectedInfo)
                IconButton(imageName: "eliminate", selectedInfo: $selectedInfo)
                IconButton(imageName: "survey", selectedInfo: $selectedInfo)
                IconButton(imageName: "option", selectedInfo: $selectedInfo)
                IconButton(imageName: "markings", selectedInfo: $selectedInfo)
            }
            .frame(width: 40)
            .padding()
            .glassBackgroundEffect()
        }
        .onDisappear {
            isManual = false
        }
        .onChange(of: landingMode) { newValue in
            switch newValue {
            case "auto":
                isManual = false
            case "semiAuto":
                isManual = false
            case "manual":
                isManual = true
            default :
                isManual = false
            }
        }
    }
}

struct camerapreviewTests: View {
    @State private var isManual = true
    var body: some View {
        cameraDetailedView(isManual: $isManual)
            .glassBackgroundEffect()
    }
}

#Preview {
    camerapreviewTests()
}
