import SwiftUI
import RealityKit

// 定义仪表盘配置的结构体
struct GaugeData {
    let value: CGFloat    // 当前数值
    let minValue: CGFloat // 最小值
    let maxValue: CGFloat // 最大值
    let unit: String      // 单位
    let icon: String      // 图标名称
}

struct gaugeMediumView: View {
    var gaugeData: GaugeData

    // 计算当前进度百分比
    private var progress: CGFloat {
        let range = gaugeData.maxValue - gaugeData.minValue
        return (gaugeData.value - gaugeData.minValue) / range
    }

    var body: some View {
        ZStack {
            // 背景圆圈
            Circle()
                .stroke(
                    Color.gray.opacity(0.3),
                    style: StrokeStyle(lineWidth: 12)
                )
                .frame(width: 150, height: 150)
            
            // 进度圆弧
            Circle()
                .trim(from: 0.0, to: progress) // 根据progress值显示进度
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [Color.green, Color.blue]),
                        center: .center,
                        startAngle: .degrees(0),
                        endAngle: .degrees(360)
                    ),
                    style: StrokeStyle(lineWidth: 12, lineCap: .round)
                )
                .rotationEffect(Angle(degrees: -220)) // 旋转起始角度
                .frame(width: 150, height: 150)
                .animation(.easeInOut(duration: 0.6), value: progress)

            // 中心内容
            VStack(spacing: 5) {
                // 显示图标
                Image(systemName: gaugeData.icon)
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
                
                // 显示当前数值
                Text("\(Int(gaugeData.value))") // 显示数值
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.primary)
                
                // 显示单位
                Text(gaugeData.unit)
                    .font(.system(size: 20))
                    .foregroundColor(.secondary)
            }
        }
        .padding(30)
    }
}

struct attitudeMediumView: View {
    var body: some View {
        Image("attitudeMedium")
            .resizable()
            .padding(30)
            .frame(width: 200, height:  200)
    }
}

struct fuelMediumView: View {
    var body: some View {
        Image("fuelMedium")
            .resizable()
            .padding(30)
            .frame(width: 200, height:  200)
    }
}

struct heightMediumView: View {
    var body: some View {
        Image("heightMedium")
            .resizable()
            .padding(30)
            .frame(width: 200, height:  200)
    }
}

struct USDZModelView: View {
    @State private var scale = false

    var body: some View {
//        Text("3D Model").font(.title)
        RealityView { content in
            let model = ModelEntity(
                    mesh: .generateSphere(radius: 0.06),
                    materials: [SimpleMaterial(color: .white, isMetallic: false)])

            // Enable interactions on the entity.
            model.components.set(InputTargetComponent())
            model.components.set(CollisionComponent(shapes: [.generateSphere(radius: 0.1)]))
            content.add(model)
        } update: { content in
            if let model = content.entities.first {
                model.transform.scale = scale ? [1.2, 1.2, 1.2] : [1.0, 1.0, 1.0]
            }
        }
        .gesture(TapGesture().targetedToAnyEntity().onEnded { _ in
            scale.toggle()
        })
    }
}

struct topographic3DMediumView: View{
    @State private var isShowingLandingPoint: Bool = false
    
    var body: some View {
        VStack{
            Text("三维地形图")
                .font(.title)
                .padding(20)
            USDZModelView()
                .frame(depth: 0)
            HStack{
                Text("显示着陆点").padding()
                Spacer()
                Toggle("显示着陆点", isOn: $isShowingLandingPoint)
                    .toggleStyle(SwitchToggleStyle())
                    .labelsHidden()
                    .padding()
            }
            .background(.thickMaterial)
            .cornerRadius(30)
            .padding(.horizontal)
            .padding(.bottom)
        }
    }
}

struct cameraMediumView: View{
    @Binding var isShowingAssistMark: Bool
    
    var body: some View {
        ZStack{
            Image("moonSurface")
                .resizable()
            VStack{
                Text("光学影像")
                    .font(.title)
                    .foregroundStyle(.primary)
                    .padding(.top, 20)
                Spacer()
                HStack{
                    Text("辅助标记").padding()
                    Spacer()
                    Toggle("辅助标记", isOn: $isShowingAssistMark)
                        .toggleStyle(SwitchToggleStyle())
                        .labelsHidden()
                        .padding()
                }
                .background(.thickMaterial)
                .cornerRadius(30)
                .padding()
            }
        }
    }
}



struct IconButton: View {
    let imageName: String
    @Binding var selectedInfo: String
    
    var body: some View {
        Button(action: {
            selectedInfo = imageName
        }) {
            Image(imageName)
                .renderingMode(selectedInfo == imageName ? .original : .template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .foregroundColor(selectedInfo == imageName ? .primary : .secondary)
        }
    }
}


#Preview {
//    topographic3DMediumView()
    let testData = GaugeData(
        value: 25,
        minValue: 0,
        maxValue: 200,
        unit: "km/h",
        icon: "timer"
    )
    gaugeMediumView(gaugeData: testData)
        .glassBackgroundEffect()
}
