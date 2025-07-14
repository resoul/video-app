import AsyncDisplayKit
import AVFoundation

final class VideoController: ASDKViewController<ASDisplayNode> {
    
    private let videoNode: VideoNode
    private let overlayNode = VideoOverlayNode()
    
    private var timer: Timer?
    
    init(_ url: URL) {
        self.videoNode = VideoNode(url)
        super.init(node: ASDisplayNode())
        self.node.automaticallyManagesSubnodes = true
        self.node.layoutSpecBlock = { [weak self] _, _ in
            guard let strongSelf = self else { return ASLayoutSpec() }

            return ASOverlayLayoutSpec(
                child: strongSelf.videoNode,
                overlay: ASInsetLayoutSpec(
                    insets: UIEdgeInsets(top: .infinity, left: 40, bottom: 60, right: 40),
                    child: strongSelf.overlayNode
                )
            )
        }
        
        overlayNode.onSeek = { [weak self] time in
            guard let self = self, let duration = self.videoNode.getCurrentItem()?.duration.seconds, duration.isFinite else {
                return
            }
            self.videoNode.seek(to: CMTime(seconds: Double(time) * duration, preferredTimescale: 600))
        }
        startTimer()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.updateOverlay()
        }
    }
    
    private func updateOverlay() {
        guard let item = videoNode.getCurrentItem() else { return }

        let current = item.currentTime().seconds
        let total = item.duration.seconds

        guard current.isFinite, total.isFinite else { return }
        
        overlayNode.updateDuration(current: current, total: total)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
