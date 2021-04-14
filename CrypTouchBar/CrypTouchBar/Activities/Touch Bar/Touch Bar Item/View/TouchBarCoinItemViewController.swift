import Cocoa

class TouchBarCoinItemController: NibViewController<TouchBarCoinItemView> {

    var coinDetails: CoinDetails
    var priceStatus: CoinUtils.PriceStatus = .stable

    var displayCoin: DisplayCoin? {
        didSet {
            self.rootView.update(nameLabelText: self.coinDetails.displayName,
                                 priceLabelText: self.displayCoin?.displayPrice ?? "",
                                 priceLabelColor: self.priceStatus.color)
        }
    }

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

    func startFetch() {
        CoinService.shared.getCurrentPrice(symbol: coinDetails.symbol, completion: { [weak self] newCoin in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let currentPrice = Double(self.displayCoin?.price ?? ""), let newPrice = Double(newCoin.price) {
                    self.priceStatus =
                        CoinUtils.getPriceStatus(previousPrice: currentPrice, currentPrice: newPrice)
                }
                self.displayCoin = newCoin
            }
            // Fetch again 3 seconds after the initial fetch succeeds to not send too many request
            // Binance bans IPs that spam requests
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: { [weak self] in
                self?.startFetch()
            })
        })
    }
}
