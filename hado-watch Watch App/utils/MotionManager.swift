//
//  MotionManager.swift
//  hado-watch Watch App
//
//  Created by song on 2024/7/8.
//

import Alamofire
import AVFoundation
import CoreMotion
import Foundation
import SocketIO
import WatchConnectivity

// 运动管理器
class MotionManager: NSObject, ObservableObject {
    private var motionManager: CMMotionManager
    @Published var deviceMotion: CMDeviceMotion?
    @Published var accelerometerData: CMAccelerometerData?
    @Published var armDirection: String = "未知"
    private var previousArmDirection: String = "未知"
//    @EnvironmentObject var healthKitManager: HealthKitManager
    private var socketManager: SocketManager
    private var socket: SocketIOClient
    private let audioPlayerManager = AudioPlayerManager()

    // 用bundle ID来做key
    private let uuidKey = "com.fai-link.app.withome.HadoWitHome.watchkitapp"

    override init() {
        self.motionManager = CMMotionManager()
        self.deviceMotion = nil
        self.socketManager = SocketManager(socketURL: URL(string: "http://192.168.1.52:8998")!, config: [.log(true), .compress])
        self.socket = socketManager.defaultSocket
        super.init()
        // 启动设备运动更新
        startDeviceMotionUpdates()
        // 启动加速计时器
        startAccelerometerUpdates()
        // 安装SocketIO
        setupSocketIO()
    }

    // keyChain implementation
    var uniqueDeviceIdentifier: String {
        if let data = KeychainHelper.shared.load(key: uuidKey),
           let uuid = String(data: data, encoding: .utf8)
        {
            return uuid
        } else {
            let uuid = UUID().uuidString
            let res = KeychainHelper.shared.save(key: uuidKey, data: Data(uuid.utf8))
            print("KeychainHelper res\(res)")
            return uuid
        }
    }

    private func setupSocketIO() {
        socket.on(clientEvent: .connect) { _, _ in
            print("Socket connected")
        }

        socket.on(clientEvent: .disconnect) { _, _ in
            print("Socket disconnected")
        }

        socket.connect()
    }

    func startDeviceMotionUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] data, _ in
                guard let self = self, let data = data else { return }
                self.deviceMotion = data
                self.updateArmDirection()
            }
        }
    }

    func startAccelerometerUpdates() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] data, _ in
                guard let self = self, let data = data else { return }
                self.accelerometerData = data
            }
        }
    }

    func playSound(forCase caseNum: Int) {
        audioPlayerManager.playSound(forCase: caseNum)
    }

    // 更新手臂方向
    func updateArmDirection() {
        guard let motion = deviceMotion else { return }

        let roll = motion.attitude.roll
        let pitch = motion.attitude.pitch
        let yaw = motion.attitude.yaw

//        let accX = motion.userAcceleration.x
//        let accY = motion.userAcceleration.y
//        let accZ = motion.userAcceleration.z

        // 更新手臂方向的判断逻辑
        if pitch > 1.0 {
            print("pitch touched::", pitch)
            armDirection = "向后"
        } else if pitch < -1.0 {
            print("pitch touched::", pitch)
            armDirection = "向前"
            playSound(forCase: 1)
        } else if roll > 0.5 {
            print("roll touched::", roll)
            armDirection = "正在放下"
            playSound(forCase: 7)
        } else if roll < -0.5 {
            print("roll touched::", roll)
            armDirection = "正在向上"
            playSound(forCase: 7)
        } else if yaw > 1.0 || yaw < -1.0 {
            print("yaw touched::", yaw)
            armDirection = "向前"
            playSound(forCase: 1)
        } else {
            armDirection = "发射"
            playSound(forCase: 2)
        }

        print("当前状态: ArmDirection: \(armDirection)")

        if armDirection != previousArmDirection {
            previousArmDirection = armDirection
            print("当前状态: ArmDirection: \(armDirection)")
            sendMotionData()
        }
    }

    func sendMotionData() {
        print("Unique mykey is :::", uniqueDeviceIdentifier)
        // 使用protobuf序列化数据
        var motionData = MotionData()
        motionData.roll = deviceMotion?.attitude.roll ?? 0
        motionData.pitch = deviceMotion?.attitude.pitch ?? 0
        motionData.yaw = deviceMotion?.attitude.yaw ?? 0
        motionData.accX = deviceMotion?.userAcceleration.x ?? 0
        motionData.accY = deviceMotion?.userAcceleration.y ?? 0
        motionData.accZ = deviceMotion?.userAcceleration.z ?? 0
        motionData.armDirection = armDirection

        guard let data = try? motionData.serializedData() else {
            print("Failed to serialize MotionData")
            return
        }

        // 发送json数据
        let motionJson: [String: Double] = ["roll": deviceMotion?.attitude.roll ?? 0,
                                            "pitch": deviceMotion?.attitude.pitch ?? 0,
                                            "yaw": deviceMotion?.attitude.yaw ?? 0,
                                            "accX": deviceMotion?.userAcceleration.x ?? 0,
                                            "accY": deviceMotion?.userAcceleration.y ?? 0,
                                            "accZ": deviceMotion?.userAcceleration.z ?? 0]
        sendAlamofireData(motionData: motionJson)

        if WCSession.default.isReachable {
            WCSession.default.sendMessageData(data, replyHandler: { _ in
                print("Data sent successfully")
            }) { error in
                print("Error sending data: \(error.localizedDescription)")
            }
        }
    }

    func sendAlamofireData(motionData: [String: Double]) {
        print("sendAlamofireData--data:\(motionData)")
        // 准备一个url
        let url = "http://192.168.1.52:8998/watch"
        // 使用Alamofile发起请求
        AF.request(url, method: .post, parameters: motionData, encoding: JSONEncoding.default).responseData(completionHandler: { res in
            // response.result为枚举类型，所以需要使用switch
            switch res.result {
                case let .success(Data):
                    // 将Data类型的数据转为Json字符串
                    let jsonString = try? JSONSerialization.jsonObject(with: Data)
                    // 打印json字符串
                    print("success\(String(describing: jsonString))")
                case let .failure(error):
                    print("error\(error)")
            }
            // print("响应数据：\(res.result)")
        })
    }

    func sendMotionDataViaSocketIO(motionData: Data) {
        socket.emit("motion_data", motionData)
        print("Motion data sent via Socket.IO")
    }
}
