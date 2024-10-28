import SwiftUI

struct CompassPreviewView: View {
    // 使用一些静态的示例数据
    @State private var yaw: CGFloat = 160 // 当前航向（0-360度）
    @State private var targetDistance: Int = 129 // 到目标的距离（米）
    @State private var targetDirection: CGFloat = 120 // 目标方向（0-360度）
    
    var body: some View {
        ZStack {
            // 背景罗盘
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.black.opacity(0.8))
                .frame(width: 400, height: 100)
                .shadow(radius: 10)
                
            HStack(spacing: 20) {
                // 当前方向刻度
                ForEach(0..<12) { index in
                    let angle = CGFloat(index) * 30
                    Text(directionName(for: angle))
                        .font(.caption)
                        .foregroundColor(angle == yaw ? .white : .gray)
                }
            }
            .padding(.horizontal, 20)

            // 距离与航向信息
            HStack {
                // 目标距离
                HStack(spacing: 5) {
                    Image(systemName: "location.fill")
                        .foregroundColor(.red)
                    Text("\(targetDistance) m")
                        .foregroundColor(.red)
                        .font(.headline)
                }
                Spacer()
                
                // 目标方向
                HStack(spacing: 5) {
                    Image(systemName: "arrowtriangle.down.fill")
                        .foregroundColor(.green)
                    Text("\(Int(targetDirection))°")
                        .foregroundColor(.green)
                        .font(.headline)
                }
            }
            .padding(.horizontal, 20)
        }
        .padding()
    }
    
    // Helper function to get direction name for a given angle
    private func directionName(for angle: CGFloat) -> String {
        switch angle {
        case 0: return "N"
        case 30: return "NE"
        case 60: return "E"
        case 90: return "SE"
        case 120: return "S"
        case 150: return "SW"
        case 180: return "W"
        case 210: return "NW"
        case 240: return "N"
        case 270: return "W"
        case 300: return "NW"
        case 330: return "N"
        default: return ""
        }
    }
}

struct CompassPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        CompassPreviewView()
    }
}
