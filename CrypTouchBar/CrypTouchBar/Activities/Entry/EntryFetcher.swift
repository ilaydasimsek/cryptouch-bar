import Foundation

class EntryFetcher {
    func getCoinInfo(completion: (([Coin]) -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            completion?([
                Coin(name: "BTC/USDT", currentPrice: 58123.456),
                Coin(name: "ETH/USDT", currentPrice: 2100.5),
                Coin(name: "LINA/USDT", currentPrice: 0.00234),
            ])
        })
    }
}
