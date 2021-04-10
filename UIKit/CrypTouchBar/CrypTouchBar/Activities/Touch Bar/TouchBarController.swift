import Cocoa

class TouchBarController: NSObject {
    var touchBarViewId = NSTouchBarItem.Identifier("com.cryptouchbar.coinbar.".appending(UUID().uuidString))
    var touchBarMainItemId = NSTouchBarItem.Identifier("com.cryptouchbar.coinbar")
    var touchBarView: TouchBarView?
    var touchBar: NSTouchBar = NSTouchBar()

    override init() {
        super.init()
        prepareListeners()
        prepareVisibilityHandlers()
        prepareTouchBar()
    }
}

private extension TouchBarController {

    func prepareListeners() {
        NotificationCenter.default.addObserver(self, selector: #selector(onSelectedCoinsChanged(_:)), name: .onFavoriteCoinsChanged, object: nil)
    }

    func prepareVisibilityHandlers() {
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(activeApplicationChanged), name: NSWorkspace.didLaunchApplicationNotification, object: nil)
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(activeApplicationChanged), name: NSWorkspace.didTerminateApplicationNotification, object: nil)
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(activeApplicationChanged), name: NSWorkspace.didActivateApplicationNotification, object: nil)
    }

    func prepareTouchBar() {
        touchBar.delegate = self
        touchBar.defaultItemIdentifiers = [touchBarViewId]
        touchBarView = TouchBarView(identifier: touchBarViewId,
                                    items: createTouchBarChildrenItems())
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

    @objc func onSelectedCoinsChanged(_ notification: Notification) {
        touchBarView?.refreshItems(createTouchBarChildrenItems())
    }
}

// MARK: - View creation
private extension TouchBarController {

    func createTouchBarChildrenItems() -> [NSTouchBarItem] {
        return CoinPreferenceStorageService.favoriteCoinSymbols.map({ symbol in
            self.createCoinItem(withSymbol: symbol)
        })
    }

    func createCoinItem(withSymbol symbol: String) -> TouchBarCoinItem {
        let itemId = createCoinItemId()
        return TouchBarCoinItem(identifier: itemId, symbol: symbol)
    }

    func createCoinItemId() -> NSTouchBarItem.Identifier {
        let currentTime = Date().timeIntervalSince1970
        let type = TouchBarCoinItem.self
        return NSTouchBarItem.Identifier("\(type)_\(currentTime)")
    }
}

extension TouchBarController: NSTouchBarDelegate {

    func touchBar(_: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        guard identifier == touchBarViewId else { return nil }
        return touchBarView
    }
}
