import Foundation
import AVFoundation
import AudioToolbox
import UIKit

@MainActor
final class SoundManager {
    static let shared = SoundManager()
    private var player: AVAudioPlayer?

    func playStartupSound(enabled: Bool) {
        guard enabled else { return }
        play("startup")
    }

    func playScanningSound(enabled: Bool) {
        guard enabled else { return }
        play("scanning")
    }

    func playConnectSound(enabled: Bool) {
        guard enabled else { return }
        play("connected")
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }

    private func play(_ name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            AudioServicesPlaySystemSound(1104)
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.volume = 0.9
            player?.prepareToPlay()
            player?.play()
        } catch {
            AudioServicesPlaySystemSound(1104)
        }
    }
}
