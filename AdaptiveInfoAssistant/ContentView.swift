import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var currentCardData: CardData
    @EnvironmentObject private var currentCardStatus: CardStatus
    
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    
    var body: some View {
        VStack {
            Picker("Select Layout", selection: $currentCardStatus.layout) {
                Text("Basic").tag(CardLayout.basic)
                Text("Medium Detail").tag(CardLayout.mediumDetail)
                Text("Detailed").tag(CardLayout.detailed)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            Spacer()
            Button("创建信息卡片") {
                openWindow(id:"infoCard")
            }
            .padding()
            Toggle("进入登月着陆信息辅助模拟模式", isOn: $showImmersiveSpace)
                .toggleStyle(.button)
            Spacer()
        }
        .padding()
        .onChange(of: showImmersiveSpace) { _, newValue in
            Task {
                if newValue {
                    openWindow(id:"landingTaskView")
                } else  {
                    dismissWindow(id:"landingTaskView")
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(CardData(title: "Sample Title", iconName: "star.fill"))
        .environmentObject(CardStatus(layout: .basic))
        .frame(width: 600, height: 300)
        .glassBackgroundEffect()
}
