import SwiftUI

struct RotatingCompassView: View {
    @State private var topRotationAngle: Double = 0 // 顶部标尺旋转角度
    @State private var bottomRotationAngle: Double = 0 // 底部标尺旋转角度
    let rotationSpeed: Double = 20 // 旋转速度

    var body: some View {
        ZStack {
            // 绿色圆圈部分
            Circle()
                .stroke(Color.green, lineWidth: 2)
                .frame(width: 300, height: 300)

            // 中心静止的指针
            VStack {
                Image(systemName: "arrowtriangle.down.fill")
                    .foregroundColor(.green)
                    .rotationEffect(.degrees(180))
            }

            // 顶部背景标尺（独立旋转）
            GeometryReader { geometry in
                Image("topRuler")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 1.5)
                    .rotationEffect(.degrees(topRotationAngle))
                    .animation(.linear(duration: 0.5), value: topRotationAngle)
            }
            .frame(height: 100)
            .position(x: UIScreen.main.bounds.width / 2, y: 150)

            // 底部背景标尺（独立旋转）
            GeometryReader { geometry in
                Image("bottomRuler")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 1.5)
                    .rotationEffect(.degrees(bottomRotationAngle))
                    .animation(.linear(duration: 0.5), value: bottomRotationAngle)
            }
            .frame(height: 100)
            .position(x: UIScreen.main.bounds.width / 2, y: 300)

            // 左侧背景标尺（不旋转）
            GeometryReader { geometry in
                Image("leftRuler")
                    .resizable()
                    .scaledToFit()
                    .frame(height: geometry.size.height * 1.5)
                    .offset(y: -geometry.size.height / 4)
                    .animation(.linear(duration: 0.5), value: topRotationAngle)
            }
            .frame(width: 50)
            .position(x: 50, y: UIScreen.main.bounds.height / 2)

            // 蒙版层
            Circle()
                .stroke(Color.black.opacity(0.5), lineWidth: 100)
                .frame(width: 400, height: 400)
                .mask(
                    LinearGradient(gradient: Gradient(colors: [
                        Color.clear, Color.black, Color.clear
                    ]), startPoint: .leading, endPoint: .trailing)
                )
        }
        .onAppear {
            startRotation()
        }
    }

    // 启动旋转动画
    func startRotation() {
        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
            withAnimation(.linear(duration: 0.02)) {
                topRotationAngle += rotationSpeed * 0.02
                bottomRotationAngle -= rotationSpeed * 0.02
                if topRotationAngle >= 360 {
                    topRotationAngle = 0
                }
                if bottomRotationAngle <= -360 {
                    bottomRotationAngle = 0
                }
            }
        }
    }
}

struct RotatingCompassView_Previews: PreviewProvider {
    static var previews: some View {
        RotatingCompassView()
            .frame(width: 400, height: 400)
    }
}