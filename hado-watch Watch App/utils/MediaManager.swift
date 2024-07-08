//
//  MediaManager.swift
//  hado-watch Watch App
//
//  Created by song on 2024/7/8.
//

import AVFoundation
import Foundation

class AudioPlayerManager {
    private var player: AVAudioPlayer?

    // 播放指定编号的音频文件
    func playSound(forCase caseNum: Int) {
        print("playSound \(caseNum)")
    }

    // 根据caseNum获取音频文件的URL
    private func audioURL(forCase caseNum: Int) -> URL? {
        let soundName: String
        switch caseNum {
        case 1:
            soundName = "2"
        case 2:
            soundName = "4"
        case 3:
            soundName = "7"
        default:
            return nil // 无效的caseNum，返回nil
        }
        return Bundle.main.url(forResource: soundName, withExtension: "mp3")
    }
}
