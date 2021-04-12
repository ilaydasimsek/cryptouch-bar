import Cocoa

class CoinsTableViewController: NSViewController {
    @IBOutlet weak var tableView: NSTableView!

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
