import SwiftUI
import Foundation

// 定义仪表盘配置的结构体
class GaugeData: ObservableObject {
    @Published var value: CGFloat
    let minValue: CGFloat
    let maxValue: CGFloat
    let unit: String
    let icon: String

    init(value: CGFloat, minValue: CGFloat, maxValue: CGFloat, unit: String, icon: String) {
        self.value = value
        self.minValue = minValue
        self.maxValue = maxValue
        self.unit = unit
        self.icon = icon
    }
}

// 驾驶模式的穷举变量
enum LandingMode: String {
    case auto = "auto"
    case semiAuto = "semiAuto"
    case manual = "manual"
}

// 数据结构，代表仪表盘中的所有信息项
class InfoModel: ObservableObject {
    
    @Published var altitudeGauge: GaugeData = GaugeData(value: 1000, minValue: 0, maxValue: 2000, unit: "m", icon: "altimeter")
    @Published var verticalSpeedGauge: GaugeData = GaugeData(value: -50, minValue: -100, maxValue: 0, unit: "m/s", icon: "arrow.down")
    @Published var horizontalSpeedGauge: GaugeData = GaugeData(value: 20, minValue: 0, maxValue: 100, unit: "m/s", icon: "arrow.right")
    @Published var pitchGauge: GaugeData = GaugeData(value: 0, minValue: -90, maxValue: 90, unit: "°", icon: "arrow.up")
    @Published var rollGauge: GaugeData = GaugeData(value: 0, minValue: -180, maxValue: 180, unit: "°", icon: "arrow.left.and.right")
    @Published var yawGauge: GaugeData = GaugeData(value: 0, minValue: -180, maxValue: 180, unit: "°", icon: "arrow.forward")
    @Published var fuelGauge: GaugeData = GaugeData(value: 75, minValue: 0, maxValue: 100, unit: "%", icon: "fuelpump")
    @Published var thrustGauge: GaugeData = GaugeData(value: 60, minValue: 0, maxValue: 100, unit: "%", icon: "flame")
    
    @Published var landingMode: LandingMode = .auto
    
    private var timer: Timer?

    func startUpdating() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.updateData()
        }
    }
    
    func stopUpdating() {
        timer?.invalidate()
        timer = nil
    }

    // 更新数据模拟函数
    private func updateData() {
        altitudeGauge.value = max(altitudeGauge.value + CGFloat.random(in: -10...5), 0)
        verticalSpeedGauge.value = CGFloat.random(in: -60 ... -40)
        horizontalSpeedGauge.value = CGFloat.random(in: 15 ... 25)
        pitchGauge.value = CGFloat.random(in: -5 ... 5)
        rollGauge.value = CGFloat.random(in: -10 ... 10)
        yawGauge.value = CGFloat.random(in: -5 ... 5)
        fuelGauge.value = max(fuelGauge.value - CGFloat.random(in: 0.1...0.5), 0)
        thrustGauge.value = CGFloat.random(in: 50 ... 70)
        
//        print("InfoModal Updating")
        objectWillChange.send()
    }

}

