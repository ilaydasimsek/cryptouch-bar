import Cocoa

class CoinSelectionViewController: NSViewController {

    override var nibName: NSNib.Name? {
        return "CoinSelectionView"
    }

    var rootView: CoinSelectionView {
        return self.view as! CoinSelectionView
    }

    let tableViewController: CoinsTableViewController = CoinsTableViewController()

    var coins: [CoinDetails] = [] {
        didSet { updateTableViewCoinData() }
    }

    var searchString: String = "" {
        didSet { updateTableViewCoinData() }
    }

    var visibleCoins: [CoinDetails] {
        if searchString != "" {
            return self.coins.filter { $0.displayName.lowercased()
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
            self.tableViewController.setCoinData(coins: self.coins)
        })
    }

    func updateTableViewCoinData() {
        self.tableViewController.setCoinData(coins: self.visibleCoins)
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
