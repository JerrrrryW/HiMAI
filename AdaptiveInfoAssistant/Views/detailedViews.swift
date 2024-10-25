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

import AVKit

struct cameraDetailedView: View {
    var title: String = "系统检测到光学图像显示地形异常！建议切换至半自动或手动模式。"
    var titleIcon: String = "hand.point.up"
    @State private var selectedInfo: String = "speed"
    @State private var player: AVQueuePlayer? = nil
    @State private var looper: AVPlayerLooper? = nil // 用于循环播放
    @State private var isLoading = true // 状态变量，用于显示加载状态
    
    @EnvironmentObject var model: InfoModel
    
    var body: some View {
        VStack {
            HStack {
                switch model.landingMode {
                case .auto:
                    Label(title, systemImage: "exclamationmark.circle")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.red)
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(30)
                case .manual:
                    Label("手控模式", systemImage: "hand.point.up")
                        .font(.system(size: 24, weight: .bold))
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(30)
                case .semiAuto:
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
                    // Action for second button
                }) {
                    Image("displayMarker")
                }
                .padding(.trailing)
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.top)
            .padding(.horizontal)
            
            ZStack {
                if isLoading {
                    // 显示加载状态的进度指示器
                    ProgressView("正在加载视频...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding(.bottom)
                        .padding(.horizontal)
                } else {
                    VideoPlayer(player: player)
                        .cornerRadius(30)
                        .padding(.bottom)
                        .padding(.horizontal)
                }
                
                if model.landingMode == .manual {
                    Image("supporting information")
                        .frame(height: 100)
                }
            }
        }
        .ornament(attachmentAnchor: .scene(.bottom)) {
            HStack(spacing: 10) {
                Picker("Select Layout", selection: $model.landingMode) {
                    Text("自动模式").tag(LandingMode.auto)
                    Text("半自控模式").tag(LandingMode.semiAuto)
                    Text("手控模式").tag(LandingMode.manual)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding()
            .glassBackgroundEffect()
        }
        .ornament(attachmentAnchor: .scene(.leading)) {
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
        .onAppear {
            // 异步加载视频，确保不会阻塞主线程
            DispatchQueue.global(qos: .userInitiated).async {
                // 模拟加载时间
                guard let videoURL = Bundle.main.url(forResource: "F-d1", withExtension: "mp4") else { return }
                let asset = AVURLAsset(url: videoURL)
                let item = AVPlayerItem(asset: asset)
                
                // 在主线程更新 UI 和视频播放器
                DispatchQueue.main.async {
                    let queuePlayer = AVQueuePlayer(playerItem: item)
                    self.player = queuePlayer
                    
                    // 设置循环播放
                    self.looper = AVPlayerLooper(player: queuePlayer, templateItem: item)
                    
                    self.player?.play()
                    self.isLoading = false // 停止显示加载指示器
                }
            }
        }
    }
}


struct camerapreviewTests: View {
    @StateObject var infoModel: InfoModel = .init()
    
    var body: some View {
        cameraDetailedView()
            .environmentObject(infoModel)
            .glassBackgroundEffect()
    }
}

#Preview {
    camerapreviewTests()
}
