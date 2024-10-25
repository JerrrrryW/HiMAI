import SwiftUI


@main
struct AdaptiveInfoAssistantApp: App {
    
    @StateObject var infoModel: InfoModel = .init()
    @StateObject var layoutModel: LayoutModel = .init()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(layoutModel)
        }.defaultSize(width: 400, height: 200)
        
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
        
        WindowGroup(id: "highPriorityPanel") {
            HighPriorityView(infoItems: layoutModel.highPriorityInfoItems)
                .environmentObject(infoModel)
                .environmentObject(layoutModel)
        }
        .windowStyle(.plain)
        
//        WindowGroup(id:"cameraDetailedView"){
//            cameraDetailedView().glassBackgroundEffect()
//        }
    }
}
