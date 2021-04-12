import Cocoa

class MainViewController: NSViewController {
    override var nibName: NSNib.Name? {
        return "MainView"
    }

    @IBOutlet weak var tableViewContainer: NSView!
    @IBOutlet weak var searchField: NSSearchField!

    let coinService = CoinService()

    let tableViewController: CoinsTableViewController = CoinsTableViewController()
    var coins: [Coin] = [] {
        didSet {
            self.tableViewController.setCoinData(coins: self.visibleCoins)
        }
    }
    var searchString: String = "" {
        didSet {
            self.tableViewController.setCoinData(coins: self.visibleCoins)
        }
    }

    var visibleCoins: [Coin] {
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
        prepareView()
    }
}

// MARK: - View preparation
private extension MainViewController {
    
    func startFetch() {
        coinService.getAllSymbols(completion: { response in
            response.binanceSymbolItems.forEach({ coin in
                self.coins.append(coin)
            })
            self.tableViewController.setCoinData(coins: self.coins)
        })
    }

    func prepareView() {
        self.tableViewContainer.addSubview(tableViewController.view)
        tableViewController.view.frame = self.tableViewContainer.bounds
        self.searchField.delegate = self
        self.searchField.sendsSearchStringImmediately = true
    }
}

extension MainViewController: NSSearchFieldDelegate {
    func searchFieldDidEndSearching(_ sender: NSSearchField) {
        self.searchString = ""
    }

    func controlTextDidChange(_ obj: Notification) {
        if let searchField = obj.object as? NSSearchField {
            searchString = searchField.stringValue
        }
    }
}
