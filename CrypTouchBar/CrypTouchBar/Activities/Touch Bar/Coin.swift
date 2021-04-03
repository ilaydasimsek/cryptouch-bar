import Foundation

class Coin: Identifiable {
    let name: String
    let currentPrice: CGFloat

    var displayPrice: String {
        return "\(currentPrice)"
    }

    init(name: String, currentPrice: CGFloat) {
        self.name = name
        self.currentPrice = currentPrice
    }
}
