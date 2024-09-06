import SwiftUI

struct ContentView: View {
    
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    
    var body: some View {
        VStack {
            Toggle("进入登月着陆信息辅助模拟模式", isOn: $showImmersiveSpace)
                .toggleStyle(.button)
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
