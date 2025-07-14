import AsyncDisplayKit

final class VideoOverlayNode: ASDisplayNode {
    
    private let durationNode = DurationNode()
    private let sliderNode = SliderNode()
    
    var onSeek: ((Float) -> Void)? {
        didSet {
            sliderNode.onSeek = onSeek
        }
    }
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = UIColor.black.withAlphaComponent(0.4)
        cornerRadius = 8
        clipsToBounds = true
        
        durationNode.updateTimeLabel(current: "00:00", total: "00:00")
    }
    
    func updateDuration(current: Double, total: Double) {
        durationNode.updateTimeLabel(current: format(seconds: current), total: format(seconds: total))
        
        guard total > 0 else { return }
        sliderNode.progress = Float(current) / Float(total)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let layout = ASStackLayoutSpec.vertical()
        layout.spacing = 8
        layout.children = [sliderNode, durationNode]
        
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20),
            child: layout
        )
    }
    
    private func format(seconds: Double) -> String {
        let totalSeconds = Int(seconds)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let secs = totalSeconds % 60

        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, secs)
        } else {
            return String(format: "%02d:%02d", minutes, secs)
        }
    }
}
