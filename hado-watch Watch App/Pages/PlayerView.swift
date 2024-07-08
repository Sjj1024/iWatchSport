//
//  PlayerView.swift
//  hado-watch Watch App
//
//  Created by song on 2024/7/8.
//

import SwiftUI

struct PlayerView: View {
    var playerName: String
    @Binding var speed: Int
    @Binding var volume: Int
    @Binding var energy: Int
    @Binding var shield: Int
    @Binding var totalPoints: Int

    var body: some View {
        VStack {
            HStack {
                Text(playerName)
                    .font(.headline)
                    .foregroundColor(.white)

                Spacer()
//                VStack {
//                    HeartAnimationView()
//                    }
//                VStack{
//                    HeartBeatText()
//                }

                Text("剩余点数: \(totalPoints)")
                    .font(.subheadline)
                    .foregroundColor(Color.white)
            }
            HStack {
                VStack {
                    HeartAnimationView()
                }
                VStack {
                    HeartBeatText()
                }
                Spacer()
                VStack {
                    Text("位置:红1")
                        .font(.subheadline)
                        .foregroundColor(Color.red)
                }
            }
            HStack {
                ParameterView(parameterName: "速度", value: $speed, color: Color.orange, totalPoints: $totalPoints)
                ParameterView(parameterName: "体积", value: $volume, color: Color.green, totalPoints: $totalPoints)
                ParameterView(parameterName: "蓄能", value: $energy, color: Color.purple, totalPoints: $totalPoints)
                ParameterView(parameterName: "护盾", value: $shield, color: Color.blue, totalPoints: $totalPoints)
            }
            .padding()
        }
        .padding()
        .background(Color.black)
    }
}


//#Preview {
//    PlayerView()
//}
