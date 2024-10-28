import SwiftUI

struct CompassPreviewView: View {
    // 使用一些动态的示例数据
    @State private var yaw: CGFloat = 160 // 当前航向（0-360度）
    @State private var targetDistance: Int = 129 // 到目标的距离（米）
    @State private var targetDirection: CGFloat = 120 // 目标方向（0-360度）
    
    var body: some View {
        ZStack {
            // 背景罗盘
//            RoundedRectangle(cornerRadius: 15)
//                .fill(Color.black.opacity(0.8))
//                .frame(width: 400, height: 100)
//                .shadow(radius: 10)
                
            // 方向刻度背景图像
            GeometryReader { geometry in
                Image("coordinate axis")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 1.5, height: geometry.size.height)
                    .offset(x: -geometry.size.width * 0.25 - ((targetDirection - 180) / 360) * geometry.size.width * 1.5)
                    .animation(.easeInOut(duration: 1), value: targetDirection) // 添加动画效果
            }
            .frame(height: 100)
            .clipped()
            .mask(
                LinearGradient(gradient: Gradient(stops: [
                    .init(color: Color.black.opacity(0.0), location: 0.0),
                    .init(color: Color.black.opacity(1.0), location: 0.1),
                    .init(color: Color.black.opacity(1.0), location: 0.4),
                    .init(color: Color.white.opacity(0), location: 0.5),
                    .init(color: Color.black.opacity(1.0), location: 0.6),
                    .init(color: Color.black.opacity(1.0), location: 0.9),
                    .init(color: Color.black.opacity(0.0), location: 1.0)
                ]), startPoint: .leading, endPoint: .trailing)
            )
          
            // 目标方向
            VStack {
                Image(systemName: "arrowtriangle.down.fill")
                    .foregroundColor(.green)
                Text("\(Int(targetDirection))°")
                    .foregroundColor(.green)
                    .font(.headline)
            }

            // 目标距离
            VStack {
                HStack(spacing: 5) {
                    Image(systemName: "location.fill")
                        .foregroundColor(.red)
                    Text("\(targetDistance) m")
                        .foregroundColor(.red)
                        .font(.headline)
                }
                .padding(.top, 10)
                Spacer()
            }
            .padding(.leading, 20)
        }
        .padding()
        .onAppear {
            // 启动一个计时器来随机更新方向
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 0.5)) {
                    targetDirection = CGFloat.random(in: 90...210)
//                    targetDistance = CGFloat.random(in: 90...120)
                }
            }
        }
    }
}

struct CompassPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        CompassPreviewView()
            .glassBackgroundEffect()
            .frame(width:500, height: 100)
    }
}
