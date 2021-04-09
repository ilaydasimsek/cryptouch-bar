import Cocoa

class CoinDescriptionCellView: NSTableCellView {
    @IBOutlet weak var coinName: NSTextField!
    @IBOutlet weak var statusIcon: NSImageView!
    
    let selectedItemIcon = NSImage(imageLiteralResourceName: "starFilledIcon")
    let unselectedItemIcon = NSImage(imageLiteralResourceName: "starEmptyIcon")

    func configure(_ coin: Coin, isSelected: Bool) {
        coinName.stringValue = getDisplayName(for: coin)
        statusIcon.image = isSelected ? selectedItemIcon : unselectedItemIcon
        statusIcon.contentTintColor = Colors.redTextColor
    }

    private func getDisplayName(for coin: Coin) -> String {
         if let baseAsset = coin.baseAsset, let quoteAsset = coin.quoteAsset {
             return "\(baseAsset)/\(quoteAsset)"
         } else {
            return coin.symbol
         }
    }
}
