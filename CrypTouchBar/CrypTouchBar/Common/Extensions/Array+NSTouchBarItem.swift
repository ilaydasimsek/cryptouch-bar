import Cocoa

extension Array where Element: NSTouchBarItem {
    var views: [NSView] {
        return self.compactMap { $0.view }
    }
}
