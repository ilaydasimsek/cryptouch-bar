import Cocoa

class NibViewController<T: NSView>: NSViewController {

    var rootView: T {
        return self.view as! T
    }

    override func loadView() {
        guard let nibView = loadViewFromNib() else {
            fatalError("Could not load nib with type \(T.nibIdentifier). Something might be wrong with the nib file.")
        }
        self.view = nibView
    }

    private func loadViewFromNib() -> T? {
        var topLevelObjects: NSArray? = nil
        Bundle.main.loadNibNamed(NSNib.Name(T.nibIdentifier), owner: self, topLevelObjects: &topLevelObjects)
        guard let results = topLevelObjects,
              let view = Array<Any>(results).filter({ $0 is T }).last as? T
              else { return nil }
        return view
    }
}
