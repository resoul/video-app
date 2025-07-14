import AsyncDisplayKit
import AVFoundation

final class VideoNode: ASDisplayNode {
    
    private let player: AVPlayer

    init(_ url: URL) {
        self.player = AVPlayer(url: url)
        super.init()
        automaticallyManagesSubnodes = true
        setViewBlock { () -> UIView in
            let view = VideoView()
            view.player = self.player
            
            return view
        }
    }
    
    override func didLoad() {
        super.didLoad()
        player.play()
    }
    
    func getCurrentItem() -> AVPlayerItem? {
        return player.currentItem
    }
    
    func seek(to time: CMTime) {
        player.seek(to: time)
    }
}
