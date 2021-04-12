import Foundation
import SwiftyJSON

extension Notification.Name {
    static let onFavoriteCoinsChanged = Notification.Name("onFavoriteCoinsChanged")
}

struct StorageKey {
    static let FAVOURITE_COINS = "FavoriteCoins"
}

class CoinPreferenceStorageService {

    static var favoriteCoins: [Coin] {
        
        guard let data = UserDefaults.standard.data(forKey: StorageKey.FAVOURITE_COINS),
              let dataJson = try? JSON(data: data)
            else { return [] }
        return dataJson.arrayValue.compactMap { Coin.decode(fromJson: $0) }
    }

    static func toggleFavoriteStatus(of coin: Coin) {
        var currentCoins = Self.favoriteCoins
        if let coinIndex = currentCoins.firstIndex(of: coin) {
            currentCoins.remove(at: coinIndex)
        } else {
            currentCoins.append(coin)
        }
        saveFavoriteCoins(currentCoins)
        NotificationCenter.default.post(name: .onFavoriteCoinsChanged, object: nil)
    }

    static func isFavorite(_ coin: Coin) -> Bool {
        return Self.favoriteCoins.contains(coin)
    }

    private static func saveFavoriteCoins(_ coins: [Coin]) {
        guard let encoded = try? JSONEncoder().encode(coins) else { return }
        UserDefaults.standard.setValue(encoded, forKey: StorageKey.FAVOURITE_COINS)
        UserDefaults.standard.synchronize()
    }
}
