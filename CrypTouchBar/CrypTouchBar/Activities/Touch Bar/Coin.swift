import Foundation
import SwiftyJSON


struct Coin: Decodable, Identifiable {    
    var id: String {
        return symbol
    }

    private let symbol: String
    private let price: String

    var name: String {
        return symbol
    }

    var displayPrice: String {
        return "\(Double(price) ?? 0)"
    }

    static func decode(fromJson json: JSON) -> Coin? {
        guard let symbol = json["symbol"].string,
              let price = json["price"].string else { return nil }
        return Coin(
            symbol: symbol, price: price
        )
    }
}

struct BinanceSymbolsResponse: Decodable {
    let binanceSymbolItems: [Coin]

    static func decode(fromJson json: JSON) -> BinanceSymbolsResponse? {
        guard let jsonList = json.array else { return nil }
  
        let binanceSymbolItems: [Coin] = jsonList.compactMap({ item in
            return Coin.decode(fromJson: item)
        })
        
        return BinanceSymbolsResponse(binanceSymbolItems: binanceSymbolItems)
    }
}
