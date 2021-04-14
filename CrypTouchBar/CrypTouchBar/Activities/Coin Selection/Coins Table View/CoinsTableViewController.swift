import Cocoa

class CoinsTableViewController: NibViewController<CoinsTableView> {

    private var coins: [CoinDetails] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
    }

    func setCoinData(coins: [CoinDetails]) {
        self.coins = coins
        DispatchQueue.main.async {
            self.rootView.tableView.reloadData()
        }
    }

    private func prepareTableView() {
        rootView.tableView.registerNib(withIdentifier: CoinDescriptionCellView.nibIdentifier)
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
    }

}

extension CoinsTableViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return coins.count
    }
}

extension CoinsTableViewController: NSTableViewDelegate {

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(CoinDescriptionCellView.nibIdentifier), owner: nil) as? CoinDescriptionCellView,
           row < coins.count {
            let coin = coins[row]
            cell.configure(coin)
            return cell
        }
        return nil
      }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return false
    }
  }
