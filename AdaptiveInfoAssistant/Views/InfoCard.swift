import SwiftUI

struct BasicCardView: View {
    var data: CardData
    
    var body: some View {
        HStack {
            Image(systemName: data.iconName)
                .scaledToFit()
            Text(data.title)
                .font(.headline)
                .padding()
        }
        .padding(30)
        .background(Color.blue.opacity(0.1))
        .glassBackgroundEffect()
    }
}

struct MediumDetailCardView: View {
    var data: CardData
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: data.iconName)
                .scaledToFill()
            VStack(alignment: .leading, spacing: 10) {
                Text(data.title)
                    .font(.headline)
                if let subtitle = data.subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                if let description = data.description {
                    Text(description)
                        .font(.body)
                        .lineLimit(2)
                }
                Spacer()
            }
//            Spacer()
        }
        .frame(maxWidth: 400)
        .padding(30)
        .shadow(radius: 5)
        .background(Color.green.opacity(0.1))
        .glassBackgroundEffect()
    }
}

struct DetailedCardView: View {
    var data: CardData
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: data.iconName)
                .scaledToFit()
            VStack(alignment: .leading, spacing: 10) {
                Text(data.title)
                    .font(.headline)
                if let subtitle = data.subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                if let description = data.description {
                    Text(description)
                        .font(.body)
                }
                if let details = data.details {
                    Text(details)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
//                Spacer()
            }
            Spacer()
        }
        .frame(maxWidth: 400)
        .padding(30)
        .shadow(radius: 5)
        .background(Color.orange.opacity(0.1))
        .glassBackgroundEffect()
    }
}

struct CardSelectionView: View {
    var data: CardData
    var cardLayout: CardLayout
    
    var body: some View {
        switch cardLayout {
        case .basic:
            BasicCardView(data: data).fixedSize()
        case .mediumDetail:
            MediumDetailCardView(data: data).fixedSize()
        case .detailed:
            DetailedCardView(data: data).fixedSize()
        }
    }
}

#Preview(){
    let selectedCardData = CardData(
        title: "15%",
        subtitle: "燃料剩余量",
        description: "实时监控登月舱剩余燃料量，以确保有足够的燃料进行着陆操作。",
        details: "剩余燃料: 15%，预计燃料消耗: 12%，警告：燃料余量低于20%。",
        iconName: "fuelpump.fill"
    )
    
    return HStack{
        CardSelectionView(data: selectedCardData, cardLayout: .basic)
        CardSelectionView(data: selectedCardData, cardLayout: .mediumDetail)
        CardSelectionView(data: selectedCardData, cardLayout: .detailed)
    }
}
