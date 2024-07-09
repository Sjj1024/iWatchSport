//
//  WatchDel.swift
//  hado-watch
//
//  Created by song on 2024/7/9.
//

import WatchConnectivity


class WatchSessionDelegate: NSObject, WCSessionDelegate, ObservableObject {
    @Published var receivedData: String = "No data received"

    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

    // Required WCSessionDelegate methods
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("Session activation failed with error: \(error.localizedDescription)")
        } else {
            print("Session activated with state: \(activationState.rawValue)")
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        // Handle session becoming inactive
        print("Session did become inactive")
    }

    func sessionDidDeactivate(_ session: WCSession) {
        // Handle session deactivation
        print("Session did deactivate")
        // Reactivate the session
        WCSession.default.activate()
    }

    func sessionReachabilityDidChange(_ session: WCSession) {
        print("Session reachability did change: \(session.isReachable)")
    }

    // Handling received data 处理接收到的消息
    func session(_ session: WCSession, didReceiveMessageData messageData: Data, replyHandler: @escaping (Data) -> Void) {
        // Process received data：使用proto反序列化
        if let motionData = try? MotionData(serializedData: messageData) {
            DispatchQueue.main.async {
                self.receivedData = "Roll: \(motionData.roll), Pitch: \(motionData.pitch), Yaw: \(motionData.yaw), accX: \(motionData.accX), accY: \(motionData.accY), accZ: \(motionData.accZ), Arm Direction: \(motionData.armDirection)"
            }
            replyHandler(Data("Success".utf8)) // Reply with success message
        } else {
            replyHandler(Data("Failure".utf8)) // Reply with failure message
        }
    }
}
