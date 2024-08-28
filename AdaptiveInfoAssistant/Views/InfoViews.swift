import SwiftUI

// High Priority - Primary Background and Foreground
struct AttitudeSpeedDetailView: View {
    let title: String // "高度", "速度", "姿态"
    let value: String // 传入的数值转化为String
    let details: [String: Float]? // 可选参数，详细数据：俯仰、滚转、偏航角

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.primary)
            Text(value)
                .font(.system(size: 40))
                .bold()
                .foregroundStyle(.primary)

            if let details = details {
                VStack(alignment: .leading) {
                    ForEach(details.sorted(by: >), id: \.key) { key, value in
                        Text("\(key): \(value)°")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.top, 10)
                .background(.ultraThinMaterial)
                .backgroundStyle(.secondary)
                .cornerRadius(10)
            }
        }
        .padding(30)
        .background(.regularMaterial)
        .backgroundStyle(.primary)
        .cornerRadius(15)
    }
}

// Medium Priority - Secondary Background and Foreground
struct AttitudeSpeedMediumPriorityView: View {
    let title: String // "高度", "速度", "姿态"
    let value: String // 传入的数值转化为String
    let details: [String: Float]? // 可选参数，详细数据：俯仰、滚转、偏航角

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title)
                .bold()
                .foregroundStyle(.secondary)
            Text(value)
                .font(.system(size: 30))
                .foregroundStyle(.secondary)
            
            if let details = details {
                VStack(alignment: .leading) {
                    ForEach(details.sorted(by: >), id: \.key) { key, value in
                        Text("\(key): \(value)°")
                            .font(.body)
                            .foregroundStyle(.tertiary)
                    }
                }
                .padding(.top, 8)
                .background(.thinMaterial)
                .backgroundStyle(.tertiary)
                .cornerRadius(8)
            }
        }
        .padding(30)
        .background(.thinMaterial)
        .backgroundStyle(.secondary)
        .cornerRadius(12)
    }
}

// Low Priority - Tertiary Background and Foreground
struct AttitudeSpeedLowPriorityView: View {
    let title: String // "高度", "速度", "姿态"
    let value: String // 传入的数值转化为String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.tertiary)
            Text(value)
                .font(.system(size: 25))
                .foregroundStyle(.tertiary)
        }
        .padding(30)
        .background(.ultraThinMaterial)
        .backgroundStyle(.tertiary)
        .cornerRadius(10)
    }
}

// High Priority - Primary Background and Foreground
struct TrajectoryPositionDetailView: View {
    let title: String // "轨迹偏差" 或 "位置偏差"
    let value: String // 传入的数值转化为String
    let detailedAnalysis: String? // 可选参数，进一步解释或建议

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.primary)
            Text(value)
                .font(.system(size: 40))
                .bold()
                .foregroundStyle(.primary)
            
            if let detailedAnalysis = detailedAnalysis {
                Text("分析: \(detailedAnalysis)")
                    .font(.title3)
                    .padding(.top, 10)
                    .background(.ultraThinMaterial)
                    .backgroundStyle(.secondary)
                    .foregroundStyle(.secondary)
                    .cornerRadius(10)
            }
        }
        .padding(30)
        .background(.regularMaterial)
        .backgroundStyle(.primary)
        .cornerRadius(15)
    }
}

// Medium Priority - Secondary Background and Foreground
struct TrajectoryPositionMediumPriorityView: View {
    let title: String // "轨迹偏差" 或 "位置偏差"
    let value: String // 传入的数值转化为String
    let detailedAnalysis: String? // 可选参数，进一步解释或建议

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title)
                .bold()
                .foregroundStyle(.secondary)
            Text(value)
                .font(.system(size: 30))
                .foregroundStyle(.secondary)
            
            if let detailedAnalysis = detailedAnalysis {
                Text("分析: \(detailedAnalysis)")
                    .font(.body)
                    .padding(.top, 8)
                    .background(.thinMaterial)
                    .backgroundStyle(.tertiary)
                    .foregroundStyle(.tertiary)
                    .cornerRadius(8)
            }
        }
        .padding(30)
        .background(.thinMaterial)
        .backgroundStyle(.secondary)
        .cornerRadius(12)
    }
}

// Low Priority - Tertiary Background and Foreground
struct TrajectoryPositionLowPriorityView: View {
    let title: String // "轨迹偏差" 或 "位置偏差"
    let value: String // 传入的数值转化为String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.tertiary)
            Text(value)
                .font(.system(size: 25))
                .foregroundStyle(.tertiary)
        }
        .padding(30)
        .background(.ultraThinMaterial)
        .backgroundStyle(.tertiary)
        .cornerRadius(10)
    }
}

// High Priority - Primary Background and Foreground
struct ImageMapDetailView: View {
    let title: String // "光学图像" 或 "三维地图"
    let image: Image // 用于展示的图像
    let description: String // 描述信息
    let tags: [String] // 关键地形标记

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.primary)
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
                .cornerRadius(10)
                .overlay(
                    Text(description)
                        .font(.title3)
                        .padding(5)
                        .background(.ultraThinMaterial)
                        .backgroundStyle(.secondary)
                        .foregroundStyle(.secondary)
                        .cornerRadius(8)
                        .padding([.top, .leading], 10),
                    alignment: .topLeading
                )
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(tags, id: \.self) { tag in
                        Text(tag)
                            .font(.caption)
                            .padding(5)
                            .background(.thinMaterial)
                            .backgroundStyle(.tertiary)
                            .foregroundStyle(.tertiary)
                            .cornerRadius(8)
                    }
                }
            }
            .padding(.top, 10)
        }
        .padding(30)
        .background(.regularMaterial)
        .backgroundStyle(.primary)
        .cornerRadius(15)
    }
}

// Medium Priority - Secondary Background and Foreground
struct ImageMapMediumPriorityView: View {
    let title: String // "光学图像" 或 "三维地图"
    let image: Image // 用于展示的图像
    let description: String // 描述信息

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title)
                .bold()
                .foregroundStyle(.secondary)
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .cornerRadius(8)
                .overlay(
                    Text(description)
                        .font(.body)
                        .padding(5)
                        .background(.ultraThinMaterial)
                        .backgroundStyle(.tertiary)
                        .foregroundStyle(.tertiary)
                        .cornerRadius(6)
                        .padding([.top, .leading], 8),
                    alignment: .topLeading
                )
        }
        .padding(30)
        .background(.thinMaterial)
        .backgroundStyle(.secondary)
        .cornerRadius(12)
    }
}

// Low Priority - Tertiary Background and Foreground
struct ImageMapLowPriorityView: View {
    let title: String // "光学图像" 或 "三维地图"
    let image: Image // 用于展示的图像

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.tertiary)
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 150)
                .cornerRadius(6)
        }
        .padding(30)
        .background(.ultraThinMaterial)
        .backgroundStyle(.tertiary)
        .cornerRadius(10)
    }
}

// High Priority - Primary Background and Foreground
struct SystemAlertDetailView: View {
    let messageType: String // "警报" 或 "操作指令" 或 "指导"
    let message: String // 具体信息
    let timestamp: String // 时间戳
    let additionalInfo: String? // 可选参数，额外信息或建议

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(messageType)
                .font(.headline)
                .foregroundStyle(.primary)
                .padding(5)
                .background(Color.red)
                .cornerRadius(5)
            
            Text(message)
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.primary)
            
            Text("时间: \(timestamp)")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            if let additionalInfo = additionalInfo {
                Text("建议: \(additionalInfo)")
                    .font(.body)
                    .padding(.top, 10)
                    .background(.ultraThinMaterial)
                    .backgroundStyle(.secondary)
                    .foregroundStyle(.secondary)
                    .cornerRadius(10)
            }
        }
        .padding(30)
        .background(.regularMaterial)
        .backgroundStyle(.primary)
        .cornerRadius(15)
    }
}

// Medium Priority - Secondary Background and Foreground
struct SystemAlertMediumPriorityView: View {
    let messageType: String // "警报" 或 "操作指令" 或 "指导"
    let message: String // 具体信息
    let timestamp: String // 时间戳

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(messageType)
                .font(.title2)
                .foregroundStyle(.secondary)
                .padding(5)
                .background(Color.orange)
                .cornerRadius(5)
            
            Text(message)
                .font(.title)
                .foregroundStyle(.secondary)
            
            Text("时间: \(timestamp)")
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .padding(30)
        .background(.thinMaterial)
        .backgroundStyle(.secondary)
        .cornerRadius(12)
    }
}

// Low Priority - Tertiary Background and Foreground
struct SystemAlertLowPriorityView: View {
    let messageType: String // "警报" 或 "操作指令" 或 "指导"
    let message: String // 具体信息

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(messageType)
                .font(.headline)
                .foregroundStyle(.tertiary)
                .padding(5)
                .background(Color.yellow)
                .cornerRadius(5)
            
            Text(message)
                .font(.body)
                .foregroundStyle(.tertiary)
        }
        .padding(30)
        .background(.ultraThinMaterial)
        .backgroundStyle(.tertiary)
        .cornerRadius(10)
    }
}

// Preview of all components in a grid
struct pContentView: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))], spacing: 20) {
                Group {
                    AttitudeSpeedDetailView(title: "高度", value: "1000 米", details: nil)
                        .glassBackgroundEffect()
                    AttitudeSpeedMediumPriorityView(title: "速度", value: "20 米/秒", details: nil).glassBackgroundEffect()
                    AttitudeSpeedLowPriorityView(title: "姿态", value: "(10°, 5°, -2°)").glassBackgroundEffect()
                    TrajectoryPositionDetailView(title: "轨迹偏差", value: "3 米", detailedAnalysis: "建议调整航向").glassBackgroundEffect()
                    TrajectoryPositionMediumPriorityView(title: "位置偏差", value: "5 米", detailedAnalysis: nil).glassBackgroundEffect()
                    TrajectoryPositionLowPriorityView(title: "轨迹偏差", value: "2 米").glassBackgroundEffect()
                    ImageMapDetailView(title: "光学图像", image: Image(systemName: "photo"), description: "前方地形", tags: ["山脉", "河流"]).glassBackgroundEffect()
                    ImageMapMediumPriorityView(title: "三维地图", image: Image(systemName: "map"), description: "当前区域地图").glassBackgroundEffect()
                    ImageMapLowPriorityView(title: "光学图像", image: Image(systemName: "photo")).glassBackgroundEffect()
                    SystemAlertDetailView(messageType: "警报", message: "高温警告", timestamp: "2024-08-26 12:34", additionalInfo: "请降低速度").glassBackgroundEffect()
                }
                Group {
                    SystemAlertMediumPriorityView(messageType: "操作指令", message: "请向左转10度", timestamp: "2024-08-26 12:35").glassBackgroundEffect()
                    SystemAlertLowPriorityView(messageType: "指导", message: "建议保持当前高度").glassBackgroundEffect()
                }
            }
            .padding()
        }
    }
}



// The following is the preview code for Xcode
#Preview {
    pContentView()
}
