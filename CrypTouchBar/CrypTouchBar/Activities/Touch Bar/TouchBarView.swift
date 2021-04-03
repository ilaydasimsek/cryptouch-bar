import SwiftUI

struct TouchBarView: View {
    let coins: [Coin]

    var body: some View {
        VStack{
        }
        .focusable()
        .touchBar { touchBar }
    }

    private var touchBar: some View {
        ForEach(coins) { coin in
            TouchBarItemView(coin: coin)
        }
    }
}

struct TouchBarView_Previews: PreviewProvider {
    static var previews: some View {
        TouchBarView(coins: [
                Coin(name: "BTC/USDT", currentPrice: 58123.456),
                Coin(name: "ETH/USDT", currentPrice: 2100.5),
                Coin(name: "LINA/USDT", currentPrice: 0.00234),
            ])
    }
}
