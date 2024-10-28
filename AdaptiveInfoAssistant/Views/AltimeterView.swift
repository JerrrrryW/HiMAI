import SwiftUI

struct AltimeterView: View {
    // 使用动态数据进行展示
    @State private var currentAltitude: CGFloat = 400 // 当前高度
    @State private var verticalSpeed: CGFloat = 2.6 // 当前纵向速度
    
    var body: some View {
        ZStack {
            // 背景标尺
            Image("height_scale")
                .resizable()
                .frame(width: 100, height: 400)
                .cornerRadius(10)
                .shadow(radius: 5)
            
            VStack {
                Spacer()
                // 当前高度标签
                HStack {
                    Spacer()
                    Text("\(Int(currentAltitude))")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                    Spacer()
                }
                .offset(y: CGFloat(-currentAltitude / 800 * 400) + 200)
                
                // 纵向速度标签
                HStack {
                    Spacer()
                    Text("\(verticalSpeed, specifier: "%.1f") m/s")
                        .font(.subheadline)
                        .foregroundColor(.cyan)
                        .padding(4)
                        .background(RoundedRectangle(cornerRadius: 5).stroke(Color.cyan, lineWidth: 1))
                    Spacer()
                }
                .offset(y: CGFloat(-currentAltitude / 800 * 400) + 200 + 30)
            }
        }
        .padding()
        .frame(width: 100, height: 400)
        .onAppear {
            // 启动动态更新模拟
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 1.0)) {
                    currentAltitude = CGFloat.random(in: 0...800)
                    verticalSpeed = CGFloat.random(in: -5...5)
                }
            }
        }
    }
}

struct AltimeterView_Previews: PreviewProvider {
    static var previews: some View {
        AltimeterView()
    }
}
