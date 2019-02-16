import UIKit
import AVKit

class PlayerViewController: AVPlayerViewController {

    let kStatusKey = "status"

    var playerItem: AVPlayerItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let mediaURL = URL(string: "https://video-dev.github.io/streams/x36xhzz/x36xhzz.m3u8") {
            playerItem = AVPlayerItem(url: mediaURL)
            playerItem?.addObserver(self, forKeyPath: kStatusKey, options: [.new, .initial], context: nil)
            if let playerItem = playerItem {
                self.player = AVPlayer(playerItem: playerItem)
                self.player?.play()
            }
            self.videoGravity = .resizeAspectFill
        }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: .defaultToSpeaker)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch { }

        self.entersFullScreenWhenPlaybackBegins = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        playerItem?.removeObserver(self, forKeyPath: kStatusKey)
        playerItem = nil
    }

    deinit {
        playerItem?.removeObserver(self, forKeyPath: kStatusKey)
        playerItem = nil
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("observeValueForKeyPath")

        if keyPath == kStatusKey, let playerItem = object as? AVPlayerItem {

            print("playerItem.status \(playerItem.status.rawValue)")

            if playerItem.status == .failed {
                print("playbackDidFail")
            }

            if playerItem.status == .readyToPlay {
                print("playbackDidSucceed")
            }

            UIApplication.shared.isIdleTimerDisabled = playerItem.status == .readyToPlay
        }
    }
}
