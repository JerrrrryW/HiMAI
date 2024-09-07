import SwiftUI


@main
struct AdaptiveInfoAssistantApp: App {
    
    @StateObject var infoModel: InfoModel = .init()
    @StateObject var layoutModel: LayoutModel = .init()
    
    @State var isManual: Bool = false
    @State var leftPanelInfoItems: [InfoItem] = [
        InfoItem(item: "hSpeed", priority: "medium"),
        InfoItem(item: "vSpeed", priority: "medium"),
        InfoItem(item: "attitude", priority: "medium"),
        InfoItem(item: "fuel", priority: "medium"),
        InfoItem(item: "height", priority: "medium")
    ]
    @State var  rightPanelInfoItems: [InfoItem] = [
        InfoItem(item: "camera", priority: "medium"),
        InfoItem(item: "topographic3D", priority: "medium")
    ]
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(layoutModel)
                .fixedSize()
        }.windowResizability(.contentSize)
        
        WindowGroup(id:"landingTaskView"){
            LandingTaskView()
        }
        .windowStyle(.plain)
        .defaultSize(width: 2160, height: 1080)
        
        WindowGroup(id:"leftAssistPanel"){
            LeftPanel(infoItems: layoutModel.leftPanelInfoItems)
                .environmentObject(infoModel)
        }
        .windowStyle(.plain)
        .defaultSize(width:500, height: 1080)
        
        WindowGroup(id:"rightAssistPanel"){
            RightPanel(infoItems: layoutModel.rightPanelInfoItems)
                .environmentObject(infoModel)
        }.windowStyle(.plain)
        
        WindowGroup(id:"cameraDetailedView"){
            cameraDetailedView(isManual: $isManual).glassBackgroundEffect()
        }
    }
}
