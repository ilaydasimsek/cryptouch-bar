import Cocoa

class MainViewController: NSViewController {
    override var nibName: NSNib.Name? {
        return "MainView"
    }

    @IBOutlet weak var tableViewContainer: NSView!
    @IBOutlet weak var searchField: NSSearchField!

    let coinService = CoinService()

    let tableViewController: CoinsTableViewController = CoinsTableViewController()
    var coins: [Coin] = []

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
    }
}
