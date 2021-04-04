import SwiftUI

class EntryViewModel: ObservableObject {
    @Published var itemSymbols: [String] = ["BTCUSDT", "LINABTC", "DOCKBTC"]

    private let coinService = CoinService()
}
