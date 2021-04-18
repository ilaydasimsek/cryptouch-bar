import Foundation
import SwiftUI

class CoinUtils {
    enum PriceStatus {
        case increasing
        case decreasing
        case stable

        var color: NSColor {
            switch self {
            case .increasing:
                return Colors.greenTextColor
            case .decreasing:
                return Colors.redTextColor
            case .stable:
                return Colors.defaultTextColor
            }
        }
    }

    private static let epsilonPercentage = 0.005

    static func getPriceStatus(previousPrice: Double, currentPrice: Double) -> PriceStatus {
        let difference: Double = (currentPrice - previousPrice) / previousPrice * 100
        if abs(difference) <= Self.epsilonPercentage {
            return .stable
        } else if difference < 0 {
            return .decreasing
        } else {
            return .increasing
        }
    }

    
    /**
        Calculates the amount of decimal places to show while displaying a coin price.
     
        Uses the tickSize value taken from Binance.
     
        Example:
     
        Let tickSize = "0.00001000" for the coinDetails item. The 1 in the string represents the last digit to show when displaying the price. So in this case the amount visible decimal places will be equal to 5
     
     - parameter coinDetails: The CoinDetails item returned from Binance

     */
    static func calculateVisibleDecimalPlaces(for coinDetails: CoinDetails) -> Int? {
        guard let startIndex: Int = coinDetails.tickSize.firstIndex(of: "."),
              let endIndex: Int = coinDetails.tickSize.firstIndex(of: "1")
        else { return nil }
        return endIndex - startIndex
    }
}
