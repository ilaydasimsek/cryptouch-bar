import Cocoa

class CoinSelectionView: NSView {
    @IBOutlet weak var tableViewContainer: NSView!
    @IBOutlet weak var searchField: NSSearchField!

    func setupView(withChild view: NSView, searchDelegate: NSSearchFieldDelegate) {
        self.tableViewContainer.addSubview(view)
        view.frame = self.tableViewContainer.bounds
        searchField.delegate = searchDelegate
    }
}
