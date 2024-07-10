//
//  WitRigView.swift
//  hado-watch Watch App
//
//  Created by song on 2024/7/8.
//

import SwiftUI
import WatchConnectivity

struct WitRigView: View {
    @State private var speed: Int = 1
    @State private var volume: Int = 1
    @State private var energy: Int = 1
    @State private var shield: Int = 1
    @State private var totalPoints: Int = 6
//    @StateObject var healthKitManager = HealthKitManager()
//    @ObservedObject private var motionManager: MotionManager
    @StateObject private var motionManager = MotionManager()

    var body: some View {
        VStack {
            // 第二个页面：陀螺仪和加速度数据
            VStack {
                Text("设备姿态数据")
                    .font(.title3)
                    .foregroundColor(.white)
                Text("Roll: \(motionManager.deviceMotion?.attitude.roll ?? 0, specifier: "%.2f")")
                    .foregroundColor(.white)
                Text("Pitch: \(motionManager.deviceMotion?.attitude.pitch ?? 0, specifier: "%.2f")")
                    .foregroundColor(.white)
                Text("Yaw: \(motionManager.deviceMotion?.attitude.yaw ?? 0, specifier: "%.2f")")
                    .foregroundColor(.white)
                Text("加速度 X: \(motionManager.accelerometerData?.acceleration.x ?? 0, specifier: "%.2f")")
                    .foregroundColor(.white)
                Text("加速度 Y: \(motionManager.accelerometerData?.acceleration.y ?? 0, specifier: "%.2f")")
                    .foregroundColor(.white)
                Text("加速度 Z: \(motionManager.accelerometerData?.acceleration.z ?? 0, specifier: "%.2f")")
                    .foregroundColor(.white)
                Text("手臂朝向: \(motionManager.armDirection)")
                    .font(.subheadline)
                    .foregroundColor(.yellow)
            }.onAppear {
                // 判断通讯WCSession是否激活，如果不是激活状态，就激活
                if WCSession.default.activationState != .activated {
                    WCSession.default.delegate = WatchSessionDelegate.shared
                    WCSession.default.activate()
                }
            }
        }
        .background(Color.black)
        .environmentObject(motionManager)
    }
}

#Preview {
    WitRigView()
}
