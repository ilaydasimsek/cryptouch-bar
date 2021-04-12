import Cocoa

class CoinDescriptionCellView: NSTableCellView {
    @IBOutlet weak var coinName: NSTextField!
    @IBOutlet weak var favouriteButton: NSButton!

    let selectedItemIcon = NSImage(imageLiteralResourceName: "heartFilledIcon")
    let unselectedItemIcon = NSImage(imageLiteralResourceName: "heartEmptyIcon")

    var coin: Coin?

    func configure(_ coin: Coin) {
        self.coin = coin
        coinName.stringValue = getDisplayName(for: coin)
        updateButtonImage()
    }

    @IBAction func onFavouriteButtonClick(_ sender: Any) {
        guard let coin = self.coin else { return }
        CoinPreferenceStorageService.toggleFavoriteStatus(of: coin)
        updateButtonImage()
    }

    private func getDisplayName(for coin: Coin) -> String {
         if let baseAsset = coin.baseAsset, let quoteAsset = coin.quoteAsset {
             return "\(baseAsset)/\(quoteAsset)"
         } else {
            return coin.symbol
         }
    }

    private func updateButtonImage() {
        guard let coin = self.coin else { return }
        let favorite = CoinPreferenceStorageService.isFavorite(coin)
        favouriteButton.image = favorite ? selectedItemIcon : unselectedItemIcon
        favouriteButton.contentTintColor = favorite ? Colors.redIconColor : Colors.defaultIconColor
    }
}
