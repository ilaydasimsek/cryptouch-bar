import Foundation
import SwiftyJSON

struct CoinDetails: Decodable, Encodable, Equatable {
    let symbol: String
    let baseAsset: String?
    let quoteAsset: String?

    var id: String {
        return symbol
    }

    var displayName: String {
        if let baseAsset = self.baseAsset, let quoteAsset = self.quoteAsset {
            return "\(baseAsset)/\(quoteAsset)"
        } else {
            return symbol
        }
    }

    static func decode(fromJson json: JSON) -> CoinDetails? {
        guard let symbol = json["symbol"].string else { return nil }
        return CoinDetails(
            symbol: symbol,
            baseAsset: json["baseAsset"].string,
            quoteAsset: json["quoteAsset"].string
        )
    }

    static func == (lhs: CoinDetails, rhs: CoinDetails) -> Bool {
        return lhs.symbol == rhs.symbol
    }
}

struct BinanceSymbolsResponse: Decodable {
    let binanceSymbolItems: [CoinDetails]

    static func decode(fromJson json: JSON) -> BinanceSymbolsResponse? {
        guard let jsonList = json["symbols"].array else { return nil }
  
        let binanceSymbolItems: [CoinDetails] = jsonList.compactMap({ item in
            return CoinDetails.decode(fromJson: item)
        })
        
        return BinanceSymbolsResponse(binanceSymbolItems: binanceSymbolItems)
    }
}
