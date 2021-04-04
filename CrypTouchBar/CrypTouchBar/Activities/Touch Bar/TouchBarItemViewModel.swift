import SwiftUI

class TouchBarItemViewModel: ObservableObject {
    @Published var coin: Coin?
    @Published var priceStatus: CoinUtils.PriceStatus = .stable

    let symbol: String
    let coinService = CoinService()

    init(symbol: String) {
        self.symbol = symbol
        self.startFetch()
    }

    func startFetch() {
        coinService.getCurrentPrice(symbol: symbol, completion: { newCoin in
            DispatchQueue.main.async {
                if let currentPrice = self.coin?.priceAmount, let newPrice = newCoin.priceAmount {
                    self.priceStatus =
                        CoinUtils.getPriceStatus(previousPrice: currentPrice, currentPrice: newPrice)
                }
                self.coin = newCoin
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: { [weak self] in
                self?.startFetch()
            })
        })
    }
}
