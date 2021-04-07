import Cocoa

class TouchBarCoinItem: NSCustomTouchBarItem, NSGestureRecognizerDelegate {

    override init(identifier: NSTouchBarItem.Identifier) {
        super.init(identifier: identifier)
        let textView = NSText()
        textView.string = "Coin Item"
        view = textView
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
