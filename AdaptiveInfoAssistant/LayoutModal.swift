import SwiftUI

// 新的LayoutModel用于动态控制左右Panel的组件
class LayoutModel: ObservableObject {
    
    // JSON-like 结构来存储每个阶段的左右面板信息项
    private let stageData: [[String: [InfoItem]]] = [
        ["left": [
            InfoItem(item: "hSpeed", priority: "medium"),
            InfoItem(item: "vSpeed", priority: "medium"),
            InfoItem(item: "attitude", priority: "medium")
        ], "right": [
            InfoItem(item: "camera", priority: "medium"),
            InfoItem(item: "topographic3D", priority: "medium")
        ]],
        ["left": [
            InfoItem(item: "fuel", priority: "medium"),
            InfoItem(item: "height", priority: "medium")
        ], "right": [
            InfoItem(item: "camera", priority: "medium")
        ]],
        // 可以继续添加更多阶段信息...
    ]
    
    // 当前阶段
    @Published var currentStage: Int = 0
    
    // 左右面板信息项
    @Published var leftPanelInfoItems: [InfoItem] = []
    @Published var rightPanelInfoItems: [InfoItem] = []
    
    init() {
        loadStage(0) // 初始化时加载第一阶段
    }
    
    // 切换到下一阶段
    func nextStage() {
        if currentStage < stageData.count - 1 {
            currentStage += 1
            loadStage(currentStage)
        }
    }
    
    // 切换到上一阶段
    func previousStage() {
        if currentStage > 0 {
            currentStage -= 1
            loadStage(currentStage)
        }
    }
    
    // 切换到指定阶段
    func switchToStage(_ stage: Int) {
        if stage >= 0 && stage < stageData.count {
            currentStage = stage
            loadStage(stage)
        }
    }
    
    // 加载指定阶段的面板信息项
    private func loadStage(_ stage: Int) {
        withAnimation(.easeInOut(duration: 0.5)) { // 过渡动画，0.5秒时长
            let stageInfo = stageData[stage]
            leftPanelInfoItems = stageInfo["left"] ?? []
            rightPanelInfoItems = stageInfo["right"] ?? []
        }
    }
}
