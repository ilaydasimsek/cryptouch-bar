import Foundation
import SwiftyJSON

let ONE_SATOSHI = "0.00000001"

struct CoinDetails: Decodable, Encodable, Equatable {
    let symbol: String
    let baseAsset: String?
    let quoteAsset: String?
    let tickSize: String

    var id: String {
        return symbol
    }

    static func decode(fromJson json: JSON) -> CoinDetails? {
        guard let symbol = json["symbol"].string else { return nil }
        return CoinDetails(
            symbol: symbol,
            baseAsset: json["baseAsset"].string,
            quoteAsset: json["quoteAsset"].string,
            tickSize: Self.getVisibleDecimalAmount(fromJson: json)
        )
    }
    
    /**
        Returns the amount of decimal places to show when displaying coin price.
     
        The value is taken from the "filters" array. In the response, the filter with type "PRICE_FILTER", has a value called "tickSize"
     which represents the amount of visible decimal places
     */
    private static func getVisibleDecimalAmount(fromJson json: JSON) -> String {
        if let savedDecimalAmount = json["tickSize"].string {
            return savedDecimalAmount
        }
        
        let filters = json["filters"].arrayValue
        var visibleDecimalAmount = ONE_SATOSHI // Default is one satoshi
 
        filters.forEach { filter in
            if filter["filterType"].string == "PRICE_FILTER",
               let tickSize = filter["tickSize"].string {
                visibleDecimalAmount = tickSize
            }
        }
        
        return visibleDecimalAmount
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
