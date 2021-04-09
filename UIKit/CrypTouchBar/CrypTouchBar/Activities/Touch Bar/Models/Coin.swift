import Foundation
import SwiftyJSON

struct DisplayCoin: Decodable {
    let symbol: String
    let price: String
    let coinDetails: Coin?

    var id: String {
        return symbol
    }

    static func decode(fromJson json: JSON) -> DisplayCoin? {
        guard let symbol = json["symbol"].string else { return nil }
        return DisplayCoin(
            symbol: symbol,
            price: json["price"].stringValue,
            coinDetails: Coin.decode(fromJson: json)
        )
    }
}

struct Coin: Decodable {
    let symbol: String
    let baseAsset: String?
    let quoteAsset: String?

    var id: String {
        return symbol
    }

    static func decode(fromJson json: JSON) -> Coin? {
        guard let symbol = json["symbol"].string else { return nil }
        return Coin(
            symbol: symbol,
            baseAsset: json["baseAsset"].string,
            quoteAsset: json["quoteAsset"].string
        )
    }
}

struct BinanceSymbolsResponse: Decodable {
    let binanceSymbolItems: [Coin]

    static func decode(fromJson json: JSON) -> BinanceSymbolsResponse? {
        guard let jsonList = json["symbols"].array else { return nil }
  
        let binanceSymbolItems: [Coin] = jsonList.compactMap({ item in
            return Coin.decode(fromJson: item)
        })
        
        return BinanceSymbolsResponse(binanceSymbolItems: binanceSymbolItems)
    }
}
