import Cocoa

class CoinsTableViewController: NSViewController {
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var coinsColumn: NSTableColumn!
    
    var coins: [Coin] = []

    override var nibName: NSNib.Name? {
        return "CoinsTableView"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
    }

    func setCoinData(coins: [Coin]) {
        self.coins = coins
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    private func prepareTableView() {
        let customCellNib = NSNib.init(nibNamed: CoinDescriptionCellView.nibIdentifier, bundle: nil)
        tableView.register(customCellNib,
                           forIdentifier: NSUserInterfaceItemIdentifier(CoinDescriptionCellView.nibIdentifier))
        tableView.delegate = self
        tableView.dataSource = self
        coinsColumn.title = "Coins"
    }

}

extension CoinsTableViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return coins.count
    }
}

extension CoinsTableViewController: NSTableViewDelegate {

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(CoinDescriptionCellView.nibIdentifier), owner: nil) as? CoinDescriptionCellView {
            cell.configure(coins[row], isSelected: false)
            return cell
        }
        return nil
      }
  }
