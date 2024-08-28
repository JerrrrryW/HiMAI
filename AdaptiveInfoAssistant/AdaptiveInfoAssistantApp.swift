import SwiftUI

enum CardLayout: String {
    case basic
    case mediumDetail
    case detailed
}

class CardData: ObservableObject {
    var title: String
    var subtitle: String?
    var description: String?
    var details: String?
    var iconName: String
    
    init(title: String, subtitle: String? = nil, description: String? = nil, details: String? = nil, iconName: String) {
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.details = details
        self.iconName = iconName
    }
}

class CardStatus: ObservableObject {
    var layout: CardLayout
    var positionX: Float
    var positionY: Float
    
    init(layout: CardLayout, positionX: Float = 0, positionY: Float = 0) {
        self.layout = layout
        self.positionX = positionX
        self.positionY = positionY
    }
}



@main
struct AdaptiveInfoAssistantApp: App {
    
    @State private var currentCardData = CardData(
        title: "15%",
        subtitle: "燃料剩余量",
        description: "实时监控登月舱剩余燃料量，以确保有足够的燃料进行着陆操作。",
        details: "剩余燃料: 15%，预计燃料消耗: 12%，警告：燃料余量低于20%。",
        iconName: "fuelpump.fill"
    )
    @State private var currentCardStatus = CardStatus(layout: .basic)
    @State var immersionState: ImmersionStyle = .full
    @State var isManual: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(currentCardData)
                .environmentObject(currentCardStatus)
                .fixedSize()
        }.windowResizability(.contentSize)
        
        WindowGroup(id:"infoCard"){
            CardSelectionView(data: currentCardData, cardLayout: currentCardStatus.layout)
                .environmentObject(currentCardData)
                .fixedSize()
        }
        .windowStyle(.plain)
        .windowResizability(.contentSize)
        
        WindowGroup(id:"landingTaskView"){
            LandingTaskView(isManual: $isManual)
        }
        .windowStyle(.plain)
        .defaultSize(width: 2160, height: 1080)
        
//        WindowGroup(id:"leftAssistPanel"){
//            VStack{
//                speedMediumView()
//                    .glassBackgroundEffect()
//                attitudeMediumView()
//                    .glassBackgroundEffect()
//                fuelMediumView()
//                    .glassBackgroundEffect()
//                heightMediumView()
//                    .glassBackgroundEffect()
//            }
//        }.windowStyle(.plain)
//        
//        WindowGroup(id:"rightAssistPanel"){
//            VStack{
//                topographic3DMediumView()
//                    .frame(width: 400, height: 300)
//                    .glassBackgroundEffect()
//            }
//        }.windowStyle(.plain)
        
        WindowGroup(id:"cameraDetailedView"){
            cameraDetailedView(isManual: $isManual).glassBackgroundEffect()
        }
    }
}
