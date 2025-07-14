import AsyncDisplayKit

final class SliderNode: ASDisplayNode {
    
    private let sliderView = FocusableSliderView()

    var onSeek: ((Float) -> Void)? {
        get { sliderView.onSeek }
        set { sliderView.onSeek = newValue }
    }

    var progress: Float {
        get { sliderView.progress }
        set { sliderView.progress = newValue }
    }
    
    override init() {
        super.init()
        backgroundColor = .clear
        setViewBlock { () -> UIView in
            return self.sliderView
        }
    }
    
    override func calculateLayoutThatFits(_ constrainedSize: ASSizeRange) -> ASLayout {
        let height: CGFloat = 30
        return ASLayout(layoutElement: self, size: CGSize(width: constrainedSize.max.width, height: height))
    }
}
