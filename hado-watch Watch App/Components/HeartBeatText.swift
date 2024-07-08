//
//  HeartBeatText.swift
//  hado-watch Watch App
//
//  Created by song on 2024/7/8.
//

import SwiftUI

struct HeartBeatText: View {
    @EnvironmentObject var healthKitManager: HealthKitManager
    var body: some View {
        HStack {
            Text("\(healthKitManager.heartRateValue) BMP")
                .bold()
                .font(.system(.subheadline, design: .rounded))
                .padding()
                .privacySensitive()
        }
        .onAppear {
            healthKitManager.startHeartRateQuery(quantityTypeIdentifier: .heartRate)
        }
    }
}

#Preview {
    HeartBeatText()
}
