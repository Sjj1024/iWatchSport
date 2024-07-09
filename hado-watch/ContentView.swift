//
//  ContentView.swift
//  hado-watch
//
//  Created by song on 2024/7/8.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    @StateObject private var watchSessionDelegate = WatchSessionDelegate()

    var body: some View {
        VStack {
            Text("Watch Motion Data:")
                .font(.headline)
            // 分割字符串
            VStack(alignment: .leading) {
                ForEach(watchSessionDelegate.receivedData.split(separator: ", "), id: \.self) { d in
                    Text(d)
                }
            }.padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding()
//            Text(watchSessionDelegate.receivedData)
//                .padding()
//                .background(Color.gray.opacity(0.2))
//                .cornerRadius(10)
//                .padding()
        }
        .onAppear {
            // Ensure WCSession is activated
            if WCSession.default.activationState != .activated {
                WCSession.default.activate()
            }
        }
    }
}

#Preview {
    ContentView()
}
