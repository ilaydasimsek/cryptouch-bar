import Cocoa

class TouchBarCoinItem: NSCustomTouchBarItem
{
    let symbol: String

    init(symbol: String) {
        self.symbol = symbol
        super.init(identifier: NSTouchBarItem.Identifier(symbol))
        viewController = TouchBarCoinItemController(symbol: symbol)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
