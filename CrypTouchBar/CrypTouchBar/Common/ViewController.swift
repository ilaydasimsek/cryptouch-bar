import Cocoa

class NibViewController<T: NSView>: NSViewController {
    
    override var nibName: NSNib.Name? {
        return T.nibIdentifier
    }

    var rootView: T {
        return self.view as! T
    }
}
