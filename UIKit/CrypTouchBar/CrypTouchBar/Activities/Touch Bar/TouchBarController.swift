import Cocoa

class TouchBarController: NSObject {
    var touchBarViewId = NSTouchBarItem.Identifier("com.cryptouchbar.coinbar.".appending(UUID().uuidString))
    var touchBarMainItemId = NSTouchBarItem.Identifier("com.cryptouchbar.coinbar")
    var touchBarView: TouchBarView
    var touchBar: NSTouchBar = NSTouchBar()

    override init() {
        touchBarView = TouchBarView(identifier: touchBarViewId, items: [])
        super.init()

        prepareVisibilityHandlers()
    }
}

private extension TouchBarController {

    func prepareVisibilityHandlers() {
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(activeApplicationChanged), name: NSWorkspace.didLaunchApplicationNotification, object: nil)
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(activeApplicationChanged), name: NSWorkspace.didTerminateApplicationNotification, object: nil)
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(activeApplicationChanged), name: NSWorkspace.didActivateApplicationNotification, object: nil)
    }

    /**
        Presents the touch bar view on top of the current touch bar.
        Can be used to override other applications touch bar when our applications goes to background

        - Warning: To show our touch bar view on top of others, this function uses exposed functions of a private touch bar api.
        There is no offical solution to show our apps touch bar view on top of other app's.
     */
    @objc func activeApplicationChanged(_: Notification) {
        NSTouchBar.presentSystemModalTouchBar(touchBar,
                                              systemTrayItemIdentifier: self.touchBarMainItemId)
    }
}

extension TouchBarController: NSTouchBarDelegate {


    func touchBar(_: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        guard identifier == touchBarViewId else { return nil }
        return touchBarView
    }
}
