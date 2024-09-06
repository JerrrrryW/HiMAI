import SwiftUI
import Foundation

// 数据结构，代表仪表盘中的所有信息项
class InfoModel: ObservableObject {
    
    // 仪表数据
    @Published var altitude: CGFloat = 1000  // 高度，单位：米
    @Published var verticalSpeed: CGFloat = -50  // 垂直速度，单位：m/s
    @Published var horizontalSpeed: CGFloat = 20 // 水平速度，单位：m/s
    @Published var pitch: CGFloat = 0    // 俯仰角，单位：度
    @Published var roll: CGFloat = 0     // 滚转角，单位：度
    @Published var yaw: CGFloat = 0      // 偏航角，单位：度
    @Published var fuelRemaining: CGFloat = 75   // 燃料剩余百分比
    @Published var thrust: CGFloat = 60   // 发动机推力比
    
    private var timer: Timer?

    // 制导信息
    @Published var expectedTrajectory: String = "Expected Trajectory"
    @Published var actualTrajectory: String = "Actual Trajectory"
    @Published var expectedSpeed: CGFloat = -45
    @Published var expectedPitch: CGFloat = 2

    // 地图信息
    @Published var opticalImage: String = "Optical Image Data"
    
    // 更新数据模拟函数
    private func updateData() {
        // 模拟高度变化：下降过程中高度递减
        altitude = max(altitude + CGFloat.random(in: -10...5), 0)

        // 模拟垂直速度：速度保持在负值区间，随着下降速度略微波动
        verticalSpeed = CGFloat.random(in: -60 ... -40)
        
        // 模拟水平速度：保持一定的水平移动
        horizontalSpeed = CGFloat.random(in: 15 ... 25)
        
        // 模拟姿态：俯仰角、滚转角和偏航角随机变化
        pitch = CGFloat.random(in: -5 ... 5)
        roll = CGFloat.random(in: -10 ... 10)
        yaw = CGFloat.random(in: -5 ... 5)
        
        // 模拟燃料余量：每次调用减少燃料
        fuelRemaining = max(fuelRemaining - CGFloat.random(in: 0.1...0.5), 0)
        
        // 模拟发动机推力波动
        thrust = CGFloat.random(in: 50 ... 70)
        
        // 你可以在这里根据需要添加更多的数据模拟逻辑
        print("altitude: \(Int(altitude)), verticalSpeed: \(Int(verticalSpeed)), horizontalSpeed: \(Int(horizontalSpeed)), pitch: \(Int(pitch)), roll: \(Int(roll)), yaw: \(Int(yaw)), fuelRemaining: \(Int(fuelRemaining)), thrust: \(Int(thrust))")
    }
    
    // 模拟数据更新
    func startUpdating() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.updateData()
        }
    }
    
    // 停止模拟
    func stopUpdating() {
        timer?.invalidate()
        timer = nil
    }

    // 创建高度表数据
    var altitudeGaugeData: GaugeData {
        GaugeData(value: altitude, minValue: 0, maxValue: 2000, unit: "m", icon: "altimeter")
    }

    // 创建垂直速度表数据
    var verticalSpeedGaugeData: GaugeData {
        GaugeData(value: verticalSpeed, minValue: -100, maxValue: 0, unit: "m/s", icon: "arrow.down")
    }

    // 创建水平速度表数据
    var horizontalSpeedGaugeData: GaugeData {
        GaugeData(value: horizontalSpeed, minValue: 0, maxValue: 100, unit: "m/s", icon: "arrow.right")
    }

    // 创建姿态表数据（俯仰角、滚转角、偏航角）
    var pitchGaugeData: GaugeData {
        GaugeData(value: pitch, minValue: -90, maxValue: 90, unit: "°", icon: "arrow.up")
    }

    var rollGaugeData: GaugeData {
        GaugeData(value: roll, minValue: -180, maxValue: 180, unit: "°", icon: "arrow.left.and.right")
    }

    var yawGaugeData: GaugeData {
        GaugeData(value: yaw, minValue: -180, maxValue: 180, unit: "°", icon: "arrow.forward")
    }

    // 创建燃料表数据
    var fuelGaugeData: GaugeData {
        GaugeData(value: fuelRemaining, minValue: 0, maxValue: 100, unit: "%", icon: "fuelpump")
    }

    // 创建推力表数据
    var thrustGaugeData: GaugeData {
        GaugeData(value: thrust, minValue: 0, maxValue: 100, unit: "%", icon: "flame")
    }
}
