import Cocoa

class TouchBarCoinItemController: NibViewController<TouchBarCoinItemView> {

    private let coinDetails: CoinDetails
    private var priceStatus: CoinUtils.PriceStatus = .stable

    private var displayCoin: DisplayCoin?

    init(coinDetails: CoinDetails) {
        self.coinDetails = coinDetails
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startFetch()
    }

}

// MARK: - View preparation
private extension TouchBarCoinItemController {
    
    func startFetch() {
        CoinService.shared.getCurrentPrice(symbol: coinDetails.symbol, completion: { [weak self] newCoin in
            guard let self = self else { return }
            self.updateDisplayCoin(with: newCoin)

            // Fetch again 3 seconds after the initial fetch succeeds to not send too many request
            // Binance bans IPs that spam requests
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: { [weak self] in
                self?.startFetch()
            })
        })
    }

    func updateDisplayCoin(with newCoin: DisplayCoin) {
        DispatchQueue.main.async {
            if let currentPrice = Double(self.displayCoin?.price ?? ""),
               let newPrice = Double(newCoin.price) {
                self.priceStatus = CoinUtils.getPriceStatus(previousPrice: currentPrice,
                                                            currentPrice: newPrice)
            }
            self.displayCoin = newCoin
            
            self.rootView.update(nameLabelText: self.coinDetails.displayName,
                                 priceLabelText: self.displayCoin?.displayPrice ?? "",
                                 priceLabelColor: self.priceStatus.color)
        }
    }
}
