import SwiftUI
import RealityKit

struct speedMediumView: View {
    var body: some View {
        Image("speedMedium")
            .resizable()
            .padding(30)
            .frame(width: 200, height:  200)
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

struct previewCardTests: View {
    @State var selectedInfo: String = "speed"
    @State private var showAlert = false
    
    @Binding var isManual: Bool
    
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    
    var body: some View {
        HStack{
            if isManual {
                VStack{
                    speedMediumView()
                        .glassBackgroundEffect()
                    attitudeMediumView()
                        .glassBackgroundEffect()
                    fuelMediumView()
                        .glassBackgroundEffect()
                    heightMediumView()
                        .glassBackgroundEffect()
                }
                .transition(.slide)
            } else {
                Grid{
                    GridRow{
                        speedMediumView()
                            .glassBackgroundEffect()
                        attitudeMediumView()
                            .glassBackgroundEffect()
                    }
                    GridRow{
                        fuelMediumView()
                            .glassBackgroundEffect()
                        heightMediumView()
                            .glassBackgroundEffect()
                    }
                }
                .transition(.slide)
            }
            Spacer()
            if isManual {
                VStack{
                    topographic3DMediumView()
                        .frame(width: 400, height: 300)
                        .glassBackgroundEffect()
                }
                .transition(.opacity)
            } else {
                VStack{
                    cameraMediumView(isShowingAssistMark: $showAlert)
                        .frame(width: 400, height: 300)
                        .glassBackgroundEffect()
                    topographic3DMediumView()
                        .frame(width: 400, height: 300)
                        .glassBackgroundEffect()
                }
                .transition(.move(edge: .trailing))
            }
        }
        .animation(.easeInOut, value: isManual)
        .ornament(attachmentAnchor: .scene(.bottom)){
            HStack(spacing: 10) {
                IconButton(imageName: "location", selectedInfo: $selectedInfo)
                IconButton(imageName: "graduated scale", selectedInfo: $selectedInfo)
                IconButton(imageName: "scale", selectedInfo: $selectedInfo)
                IconButton(imageName: "trajectory", selectedInfo: $selectedInfo)
                IconButton(imageName: "tips", selectedInfo: $selectedInfo)
            }
            .padding()
            .glassBackgroundEffect()
            Text("已折叠信息项").foregroundStyle(.secondary).font(.system(size: 20, weight: .bold))
        }
        .onChange(of: showAlert) {
            openWindow(id: "cameraDetailedView")
        }
//        .alert("系统检测到光学图像显示地形异常！建议切换至半自动或手动模式。", isPresented: $showAlert) {
//            Button("切换到手控模式", role: .cancel) {
//                // 在弹窗中点击"确定"后的操作
//                openWindow(id: "cameraDetailedView")
//                isManual = true
//            }
//            Button("保持当前模式", role: .destructive) {
//                // 在弹窗中点击"删除"后的操作
//            }
//        } message: {
//            Text("你确定要继续吗？")
//        }
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
    topographic3DMediumView()
}
