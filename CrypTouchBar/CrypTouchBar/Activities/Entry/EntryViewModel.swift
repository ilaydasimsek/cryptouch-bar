import SwiftUI

class EntryViewModel: NSObject, ObservableObject, NSTouchBarDelegate {
    @Published var coins: [Coin] = []

    private let fetcher = EntryFetcher()

    override init() {
        super.init()
       startFetch()
    }

    private func startFetch() {
        fetcher.getCoinInfo(completion: { [weak self] coins in
            guard let self = self else { return }
            self.coins = coins
        })
    }
}
