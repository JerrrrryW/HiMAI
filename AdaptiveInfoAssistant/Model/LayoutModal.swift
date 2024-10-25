import SwiftUI

// 新的LayoutModel用于动态控制左右Panel的组件
class LayoutModel: ObservableObject {
    
    // 依据着陆阶段设计的三个任务情景：接近段、悬停段、下降段
    private let stageData: [[String: [InfoItem]]] = [
        // 接近段: 中优先级为 height, attitude, fuel，其他为低优先级
        ["left": [
            InfoItem(item: "height", priority: "medium"),
            InfoItem(item: "attitude", priority: "medium"),
            InfoItem(item: "fuel", priority: "medium")
        ], "right": []
         , "ornament": [
            InfoItem(item: "vSpeed", priority: "low"),
            InfoItem(item: "hSpeed", priority: "low"),
            InfoItem(item: "roll", priority: "low"),
            InfoItem(item: "yaw", priority: "low"),
            InfoItem(item: "thrust", priority: "low"),
            InfoItem(item: "camera", priority: "low"),
            InfoItem(item: "topographic3D", priority: "low"),
            InfoItem(item: "thrustToWeightRatio", priority: "low"),
            InfoItem(item: "estimatedImpactVelocity", priority: "low")
        ], "highPriority": []],

        // 悬停段: camera 为高优先级, attitude, vSpeed, topographic3D, height, thrustToWeightRatio, estimatedImpactVelocity 为中优先级
        ["left": [
            InfoItem(item: "attitude", priority: "medium"),
            InfoItem(item: "vSpeed", priority: "medium"),
            InfoItem(item: "height", priority: "medium"),
            InfoItem(item: "thrustToWeightRatio", priority: "medium")
        ], "right": [
            InfoItem(item: "estimatedImpactVelocity", priority: "medium"),
            InfoItem(item: "topographic3D", priority: "medium")
        ], "ornament": [
            InfoItem(item: "hSpeed", priority: "low"),
            InfoItem(item: "roll", priority: "low"),
            InfoItem(item: "yaw", priority: "low"),
            InfoItem(item: "fuel", priority: "low"),
            InfoItem(item: "thrust", priority: "low")
        ], "highPriority": [
            InfoItem(item: "camera", priority: "high")
        ]],

        // 下降段: 速度、估计撞击速度、推力比、高度、垂直速度为中优先级，其他为低优先级
        ["left": [
            InfoItem(item: "vSpeed", priority: "medium"),
            InfoItem(item: "hSpeed", priority: "medium"),
            InfoItem(item: "thrustToWeightRatio", priority: "medium")
        ], "right": [
            InfoItem(item: "estimatedImpactVelocity", priority: "medium"),
            InfoItem(item: "height", priority: "medium")
        ], "ornament": [
            InfoItem(item: "attitude", priority: "low"),
            InfoItem(item: "roll", priority: "low"),
            InfoItem(item: "yaw", priority: "low"),
            InfoItem(item: "fuel", priority: "low"),
            InfoItem(item: "camera", priority: "low"),
            InfoItem(item: "topographic3D", priority: "low"),
            InfoItem(item: "thrust", priority: "low")
        ], "highPriority": []]
    ]
    
    
    // 当前阶段
    @Published var currentStage: Int = 0
    
    // 左右面板信息项
    @Published var leftPanelInfoItems: [InfoItem] = []
    @Published var rightPanelInfoItems: [InfoItem] = []
    @Published var ornamentInfoItems: [InfoItem] = []
    @Published var highPriorityInfoItems: [InfoItem] = []
    
    init() {
        loadStage(0) // 初始化时加载第一阶段
    }
    
    // 切换到下一阶段
    func nextStage() {
        if currentStage < stageData.count - 1 {
            currentStage += 1
            loadStage(currentStage)
        } else { // 循环
            currentStage = 0
            loadStage(0)
        }
    }
    
    // 切换到上一阶段
    func previousStage() {
        if currentStage > 0 {
            currentStage -= 1
            loadStage(currentStage)
        } else { // 循环
            if stageData.count > 0 {
                currentStage = stageData.count - 1
                loadStage(currentStage)
            }
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
        let stageInfo = stageData[stage]
        leftPanelInfoItems = stageInfo["left"] ?? []
        rightPanelInfoItems = stageInfo["right"] ?? []
        ornamentInfoItems = stageInfo["ornament"] ?? []
        highPriorityInfoItems = stageInfo["highPriority"] ?? []
    }
}
