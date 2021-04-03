import SwiftUI

struct TouchBarItemView: View {
    let coin: Coin

    var body: some View {
        HStack {
            Text(coin.name)
            Text(coin.displayPrice)
        }
    }
}

struct TouchBarItemView_Previews: PreviewProvider {
    static var previews: some View {
        TouchBarItemView(coin: Coin(name: "BTC/USDT", currentPrice: 58000.123 ))
    }
}
