import Foundation
import SwiftyJSON

struct DisplayCoin: Decodable {
    let symbol: String
    let price: String

    var id: String {
        return symbol
    }

    static func decode(fromJson json: JSON) -> DisplayCoin? {
        guard let symbol = json["symbol"].string else { return nil }
        return DisplayCoin(
            symbol: symbol,
            price: json["price"].stringValue
        )
    }
}
