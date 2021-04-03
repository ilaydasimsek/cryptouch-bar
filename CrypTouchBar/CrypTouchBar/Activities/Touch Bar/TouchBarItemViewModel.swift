import SwiftUI

class TouchBarItemViewModel: ObservableObject {
    @Published var coin: Coin?

    let symbol: String
    let coinService = CoinService()

    init(symbol: String) {
        self.symbol = symbol
        self.startFetch()
    }

    func startFetch() {
        coinService.getCurrentPrice(symbol: symbol, completion: { coin in
            DispatchQueue.main.async {
                self.coin = coin
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: { [weak self] in
                self?.startFetch()
            })
        })
    }
}
