import UIKit

final class FocusableSliderView: UIView {

    var progress: Float = 0.0 {
        didSet {
            progress = max(0.0, min(1.0, progress))
            setNeedsDisplay()
        }
    }

    var onSeek: ((Float) -> Void)?

    private var isFocusedNow = false

    override var canBecomeFocused: Bool {
        return true
    }

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        isFocusedNow = (context.nextFocusedView == self)
        setNeedsDisplay()
    }

    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        guard let press = presses.first else {
            super.pressesBegan(presses, with: event)
            return
        }
        
        print(press)

        switch press.type {
        case .leftArrow:
            progress -= 0.02
        case .rightArrow:
            progress += 0.02
        default:
            super.pressesBegan(presses, with: event)
            return
        }

        onSeek?(progress)
        setNeedsDisplay()
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        print(progress)
        super.pressesEnded(presses, with: event)
    }

    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }

        let barHeight: CGFloat = 6.0
        let y = (rect.height - barHeight) / 2
        let backgroundRect = CGRect(x: 0, y: y, width: rect.width, height: barHeight)
        let progressWidth = CGFloat(progress) * rect.width
        let progressRect = CGRect(x: 0, y: y, width: progressWidth, height: barHeight)

        ctx.setFillColor(UIColor.darkGray.cgColor)
        ctx.fill(backgroundRect)

        ctx.setFillColor((isFocusedNow ? UIColor.systemYellow : UIColor.white).cgColor)
        ctx.fill(progressRect)
    }
}
