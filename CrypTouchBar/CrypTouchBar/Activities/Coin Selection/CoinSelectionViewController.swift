import Cocoa

class CoinSelectionViewController: NibViewController<CoinSelectionView> {

    private let tableViewController: CoinsTableViewController = CoinsTableViewController()

    private var coins: [CoinDetails] = []
    private var searchString: String = "" {
        didSet { updateTableViewCoinData() }
    }

    private var visibleCoins: [CoinDetails] {
        if searchString != "" {
            return self.coins.filter { self.getDisplayName(coinDetails: $0).lowercased()
                                        .contains(searchString.lowercased()) }
        } else {
            return self.coins
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        startFetch()
        rootView.setupView(withChild: tableViewController.view, searchDelegate: self)
    }
}

// MARK: - View preparation
private extension CoinSelectionViewController {
    
    func startFetch() {
        CoinService.shared.getAllSymbols(completion: { response in
            response.binanceSymbolItems.forEach({ coin in
                self.coins.append(coin)
            })
            self.updateTableViewCoinData()
        })
    }

    func updateTableViewCoinData() {
        self.tableViewController.setCoinData(coins: self.visibleCoins)
    }

    func getDisplayName(coinDetails: CoinDetails) -> String {
        if let baseAsset = coinDetails.baseAsset, let quoteAsset = coinDetails.quoteAsset {
            return "\(baseAsset)/\(quoteAsset)"
        } else {
            return coinDetails.symbol
        }
    }
}

extension CoinSelectionViewController: NSSearchFieldDelegate {

    func searchFieldDidEndSearching(_ sender: NSSearchField) {
        self.searchString = ""
    }

    func controlTextDidChange(_ obj: Notification) {
        if let searchField = obj.object as? NSSearchField {
            searchString = searchField.stringValue
        }
    }
}
