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
                        
                        // 左面板测试
                        Text("左面板组件:")
                        ForEach(layoutModel.leftPanelInfoItems, id: \.item) { info in
                            Text("\(info.item) - \(info.priority)")
                        }
                        
                        // 右面板测试
                        Text("右面板组件:")
                        ForEach(layoutModel.rightPanelInfoItems, id: \.item) { info in
                            Text("\(info.item) - \(info.priority)")
                        }
                        
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
                        
                        // 测试切换到指定阶段
                        Button(action: {
                            layoutModel.switchToStage(1) // 切换到第2个阶段
                        }) {
                            Text("切换到第2阶段")
                        }
                        .padding()
        }
        .padding()
        .onChange(of: showImmersiveSpace) { _, newValue in
            Task {
                if newValue {
                    openWindow(id:"leftAssistPanel")
                    openWindow(id:"rightAssistPanel")
                } else  {
                    dismissWindow(id:"leftAssistPanel")
                    dismissWindow(id:"rightAssistPanel")
                }
            }
        }
    }
}



#Preview {
    ContentView()
        .frame(width: 600, height: 300)
        .glassBackgroundEffect()
}
