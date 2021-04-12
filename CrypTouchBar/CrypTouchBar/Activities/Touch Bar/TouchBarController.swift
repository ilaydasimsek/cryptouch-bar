import Cocoa

class TouchBarController: NSObject {
    private let touchBarViewId = NSTouchBarItem.Identifier("com.cryptouchbar.coinbar.".appending(UUID().uuidString))
    private let touchBarMainItemId = NSTouchBarItem.Identifier("com.cryptouchbar.coinbar")
    private let touchBar: NSTouchBar = NSTouchBar()

    private var touchBarView: ScrollableTouchBarView?
    private var touchBarItems: [TouchBarCoinItem] = []

    private var currentSymbols: [String] {
        return CoinPreferenceStorageService.favoriteCoinSymbols
    }

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
        touchBarItems = createTouchBarChildrenItems(for: currentSymbols)
        touchBarView = ScrollableTouchBarView(identifier: touchBarViewId,
                                    childViews: touchBarItems.views)
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
        let visibleSymbols: [String] = self.touchBarItems.map { $0.symbol }

        let removedItems = self.touchBarItems.filter { item in
            return !currentSymbols.contains(item.symbol)
        }
        
        let addedSymbols = currentSymbols.filter({ return !visibleSymbols.contains($0) })
        let newItems = self.createTouchBarChildrenItems(for: addedSymbols)

        self.touchBarItems.append(contentsOf: newItems)
        self.touchBarItems = touchBarItems.filter {!removedItems.contains($0)}

        touchBarView?.refreshItems(addedViews: newItems.views, removedViews: removedItems.views)
    }
}

// MARK: - View operations
private extension TouchBarController {

    func createTouchBarChildrenItems(for symbols: [String]) -> [TouchBarCoinItem] {
        return symbols.map({ symbol in
            self.createCoinItem(withSymbol: symbol)
        })
    }

    func createCoinItem(withSymbol symbol: String) -> TouchBarCoinItem {
        return TouchBarCoinItem(symbol: symbol)
    }
}

extension TouchBarController: NSTouchBarDelegate {

    func touchBar(_: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        guard identifier == touchBarViewId else { return nil }
        return touchBarView
    }
}
