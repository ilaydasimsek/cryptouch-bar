import Foundation

extension Notification.Name {
    static let onFavoriteCoinsChanged = Notification.Name("onFavoriteCoinsChanged")
}

struct StorageKey {
    static let FAVOURITE_COINS = "FavoriteCoinSymbols"
}

class CoinPreferenceStorageService {
    
    static var favoriteCoinSymbols: [String] {
        return UserDefaults.standard.object(forKey: StorageKey.FAVOURITE_COINS) as? [String] ?? []
    }

    static func toggleFavoriteStatus(of coin: Coin) {
        var currentSymbols = Self.favoriteCoinSymbols
        if let coinIndex = currentSymbols.firstIndex(of: coin.symbol) {
            currentSymbols.remove(at: coinIndex)
        } else {
            currentSymbols.append(coin.symbol)
        }
        UserDefaults.standard.set(currentSymbols, forKey: StorageKey.FAVOURITE_COINS)
        NotificationCenter.default.post(name: .onFavoriteCoinsChanged, object: nil)
    }

    static func isFavorite(_ coin: Coin) -> Bool {
        return Self.favoriteCoinSymbols.contains(coin.symbol)
    }
}
