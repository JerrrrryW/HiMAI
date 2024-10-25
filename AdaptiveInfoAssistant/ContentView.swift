import SwiftUI

struct ContentView: View {
    
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    
    @EnvironmentObject var layoutModel: LayoutModel

    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    
    var body: some View {
        VStack {
            Toggle("打开辅助信息面板", isOn: $showImmersiveSpace)
                .toggleStyle(.button)
            Text("当前阶段: \(layoutModel.currentStage + 1)")
                .font(.title)
            
//            // 左面板测试
//            Text("左面板组件: " + layoutModel.leftPanelInfoItems.map { "\($0.item)" }.joined(separator: ", "))
//            // 右面板测试
//            Text("右面板组件:" + layoutModel.rightPanelInfoItems.map { "\($0.item)" }.joined(separator: ", "))
//            Text("高优先级面板："+layoutModel.highPriorityInfoItems.map { "\($0.item)" }.joined(separator: ", "))
            
            HStack {
                Button(action: {
                    layoutModel.previousStage()
                }) {
                    Text("上一阶段")
                }
                .padding()
                
                Button(action: {
                    layoutModel.nextStage()
                }) {
                    Text("下一阶段")
                }
                .padding()
            }
            
//            // 测试切换到指定阶段
//            Button(action: {
//                layoutModel.switchToStage(1) // 切换到第2个阶段
//            }) {
//                Text("切换到第2阶段")
//            }
//            .padding()
        }
        .padding()
//        .ornament(attachmentAnchor: .scene(.bottom)){
//            HStack(spacing: 10) {
//                withAnimation(.easeInOut) {
//                    ForEach(layoutModel.ornamentInfoItems, id: \.item) { info in
//                        IconButton(imageName: info.item, selectedInfo: $selectedInfo)
//                    }
//                }
//            }
//            .padding()
//            .glassBackgroundEffect()
//            Text("已折叠信息项")
//                .foregroundStyle(.secondary)
//                .font(.system(size: 20, weight: .bold))
//        }
        .onChange(of: showImmersiveSpace) { _, newValue in
            Task {
                if newValue {
                    openWindow(id:"leftAssistPanel")
                    openWindow(id:"rightAssistPanel")
                    openWindow(id:"highPriorityPanel")
                } else  {
                    dismissWindow(id:"leftAssistPanel")
                    dismissWindow(id:"rightAssistPanel")
                    dismissWindow(id:"highPriorityPanel")
                }
            }
        }
        .onDisappear(){
            dismissWindow(id:"leftAssistPanel")
            dismissWindow(id:"rightAssistPanel")
            dismissWindow(id:"highPriorityPanel")
        }
    }
}


#Preview {
    // 创建一个实例的LayoutModel用于预览
    let layoutModel = LayoutModel()
    
    // 初始化 ContentView 并将 layoutModel 作为环境对象注入
    ContentView()
        .environmentObject(layoutModel)
        .padding()
        .glassBackgroundEffect()
}
