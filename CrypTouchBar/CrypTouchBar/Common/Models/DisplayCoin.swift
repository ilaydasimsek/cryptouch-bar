import Foundation
import SwiftyJSON

struct DisplayCoin: Decodable {
    let symbol: String
    let price: String
    let coinDetails: CoinDetails?

    var id: String {
        return symbol
    }

    var displayPrice: String {
        let number = NSNumber(value: Double(self.price) ?? 0.0)
        return "\(number.decimalValue)"
    }

    static func decode(fromJson json: JSON) -> DisplayCoin? {
        guard let symbol = json["symbol"].string else { return nil }
        return DisplayCoin(
            symbol: symbol,
            price: json["price"].stringValue,
            coinDetails: CoinDetails.decode(fromJson: json)
        )
    }
}
