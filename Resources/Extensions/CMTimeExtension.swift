//
//  CMTimeExtension.swift
//  MusicApp
//
//  Created by G G on 11.01.2023.
//

import Foundation
import SwiftUI
import AVKit

extension CMTime {
    func toStringTime() -> String {
        guard !CMTimeGetSeconds(self).isNaN else { return "" }
        let timeInSeconds = Int(CMTimeGetSeconds(self))
        let minutes = timeInSeconds / 60
        let seconds = timeInSeconds % 60
        let currentTime = String(format: "%02d:%02d", arguments: [minutes, seconds])
        return currentTime
    }
}
