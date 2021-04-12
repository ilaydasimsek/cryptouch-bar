import Cocoa

class TouchBarCoinItem: NSCustomTouchBarItem
{
    let coin: Coin

    init(coin: Coin) {
        self.coin = coin
        super.init(identifier: NSTouchBarItem.Identifier(coin.symbol))
        viewController = TouchBarCoinItemController(coinDetails: coin)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
