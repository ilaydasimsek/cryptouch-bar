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
}
