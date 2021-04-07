import Cocoa

class TouchBarCoinItem: NSCustomTouchBarItem, NSGestureRecognizerDelegate {

    override init(identifier: NSTouchBarItem.Identifier) {
        super.init(identifier: identifier)
        viewController = TouchBarCoinItemController()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
