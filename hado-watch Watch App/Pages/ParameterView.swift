//
//  ParameterView.swift
//  hado-watch Watch App
//
//  Created by song on 2024/7/8.
//

import SwiftUI

// 技能能量条每一列
struct ParameterView: View {
    var parameterName: String
    @Binding var value: Int
    var color: Color
    @Binding var totalPoints: Int

    var body: some View {
        VStack {
            Button(action: {
                if totalPoints > 0 {
                    value += 1
                    totalPoints -= 1
                }
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .padding()
            }
            .disabled(totalPoints == 0 || value >= 5) // 禁用按钮条件
            .opacity((totalPoints == 0 || value >= 5) ? 0.5 : 1.0) // 灰色按钮

            Text("\(value)")
                .font(.title)
                .frame(width: 40, height: 40)
                .background(color)
                .cornerRadius(8)
                .foregroundColor(.black) // 数字颜色为黑色

            Button(action: {
                if value > 1 {
                    value -= 1
                    totalPoints += 1
                }
            }) {
                Image(systemName: "minus")
                    .foregroundColor(.white)
                    .padding()
            }
            .disabled(value <= 1) // 禁用按钮条件
            .opacity(value <= 1 ? 0.5 : 1.0) // 灰色按钮

            Text(parameterName)
                .font(.caption)
                .foregroundColor(.white)
        }
    }
}


//#Preview {
//    ParameterView()
//}
