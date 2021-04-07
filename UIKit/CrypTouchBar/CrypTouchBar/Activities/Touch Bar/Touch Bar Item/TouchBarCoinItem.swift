import Cocoa

class TouchBarCoinItem: NSCustomTouchBarItem, NSGestureRecognizerDelegate {
    let symbol: String

    init(identifier: NSTouchBarItem.Identifier, symbol: String) {
        self.symbol = symbol
        super.init(identifier: identifier)
        viewController = TouchBarCoinItemController(symbol: symbol)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
