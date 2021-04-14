import Cocoa

extension NSTableView {

    func registerNib(withIdentifier nibName: String) {
        let customCellNib = NSNib.init(nibNamed: nibName, bundle: nil)
        self.register(customCellNib,
                         forIdentifier: NSUserInterfaceItemIdentifier(nibName))
    }
}
