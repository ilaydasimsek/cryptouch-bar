import Cocoa

extension NSView {
    static var nibIdentifier: String {
        return String(describing: self)
    }
}
