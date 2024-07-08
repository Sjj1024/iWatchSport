//
//  WatchSessionDelegate.swift
//  hado-watch Watch App
//
//  Created by song on 2024/7/8.
//

import WatchConnectivity
import SwiftUI

class WatchSessionDelegate: NSObject, WCSessionDelegate, ObservableObject {
    static let shared = WatchSessionDelegate()

    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

    // 必需的 WCSessionDelegate 方法
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("Session activation failed with error: \(error.localizedDescription)")
        } else {
            print("Session activated with state: \(activationState.rawValue)")
        }
    }

//    func sessionDidBecomeInactive(_ session: WCSession) {
//        // 处理 session 变为 inactive
//        print("Session did become inactive")
//    }
//
//    func sessionDidDeactivate(_ session: WCSession) {
//        // 处理 session deactivation
//        print("Session did deactivate")
//        // 重新激活 session
//        WCSession.default.activate()
//    }

    func sessionReachabilityDidChange(_ session: WCSession) {
        print("Session reachability did change: \(session.isReachable)")
    }

    // 处理接收到的数据
    func session(_ session: WCSession, didReceiveMessageData messageData: Data, replyHandler: @escaping (Data) -> Void) {
        // 处理接收到的数据
        print("Received message data: \(messageData)")
        replyHandler(Data("Success".utf8)) // 回复成功消息
    }
}

