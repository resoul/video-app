import AsyncDisplayKit
import UIKit

class DurationNode: ASDisplayNode {
    
    private let currentTimeLabel = ASTextNode()
    private let totalTimeLabel = ASTextNode()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    func updateTimeLabel(current: String, total: String) {
        currentTimeLabel.attributedText = NSAttributedString(
            string: current,
            attributes: [
                .font: UIFont.monospacedDigitSystemFont(ofSize: 20, weight: .medium),
                .foregroundColor: UIColor.white
            ]
        )

        totalTimeLabel.attributedText = NSAttributedString(
            string: total,
            attributes: [
                .font: UIFont.monospacedDigitSystemFont(ofSize: 20, weight: .medium),
                .foregroundColor: UIColor.white
            ]
        )
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let layout = ASStackLayoutSpec.horizontal()
        layout.justifyContent = .spaceBetween
        layout.children = [currentTimeLabel, totalTimeLabel]
        
        return layout
    }
}
