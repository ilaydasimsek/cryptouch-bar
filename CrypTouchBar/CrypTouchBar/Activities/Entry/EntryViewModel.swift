import SwiftUI

class EntryViewModel: ObservableObject {
    @Published var itemSymbols: [String] = ["BTCUSDT", "EPSBTC", "CFXUSDT"]

    private let coinService = CoinService()
}
