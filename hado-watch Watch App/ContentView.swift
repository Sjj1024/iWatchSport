//
//  ContentView.swift
//  hado-watch Watch App
//
//  Created by song on 2024/7/8.
//

import SwiftUI

struct ContentView: View {
//    @StateObject private var healthKitManager = HealthKitManager()
//    @EnvironmentObject var workoutManager: HealthKitManager
    @State private var features: Tab = .WitRig

    enum Tab {
        case WitRig, summary, workout, heartBeat
    }

    var body: some View {
        TabView(selection: $features, content: {
            WitRigView().tag(Tab.WitRig)
//            WorkoutListScreen().tag(Tab.workout)
//            ActivityRings().tag(Tab.summary)
//            HeartBeatScreen().tag(Tab.heartBeat)
//            StepScreen().tag(Tab.step)
//            BreathScreen().tag(Tab.breath)
        })
        .tabViewStyle(PageTabViewStyle())
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ContentView()
}
