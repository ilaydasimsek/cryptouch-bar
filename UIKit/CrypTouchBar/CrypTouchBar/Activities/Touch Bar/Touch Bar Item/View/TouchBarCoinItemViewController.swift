import Cocoa

class TouchBarCoinItemController: NSViewController {
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var priceLabel: NSTextField!

    let coinService = CoinService()
    let symbol: String
    var coin: Coin?
    var priceStatus: CoinUtils.PriceStatus = .stable

    override var nibName: NSNib.Name? {
        return "TouchBarCoinItemView"
    }

    init(symbol: String) {
        self.symbol = symbol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareView()
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startFetch()
    }

    func startFetch() {
        coinService.getCurrentPrice(symbol: symbol, completion: { [weak self] newCoin in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let currentPrice = self.coin?.priceAmount, let newPrice = newCoin.priceAmount {
                    self.priceStatus =
                        CoinUtils.getPriceStatus(previousPrice: currentPrice, currentPrice: newPrice)
                }
                self.coin = newCoin
                self.resetupView()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: { [weak self] in
                self?.startFetch()
            })
        })
    }

    func resetupView() {
        guard let coin = coin else { return }
        self.view.isHidden = false
        nameLabel.stringValue = coin.name
        priceLabel.stringValue = coin.displayPrice
        priceLabel.textColor = priceStatus.color
        nameLabel.textColor = Colors.defaultTextColor
        self.view.layoutSubtreeIfNeeded()
    }
}

private extension TouchBarCoinItemController {
    
    func prepareView() {
        self.view.wantsLayer = true
        self.view.layer?.cornerRadius = 8
        self.view.layer?.borderWidth = 2
        self.view.layer?.borderColor = Colors.borderColor.cgColor
        self.view.layer?.backgroundColor = Colors.mainBackgroundColor.cgColor
        self.view.isHidden = true
        nameLabel.stringValue = ""
        priceLabel.stringValue = ""
    }
}
