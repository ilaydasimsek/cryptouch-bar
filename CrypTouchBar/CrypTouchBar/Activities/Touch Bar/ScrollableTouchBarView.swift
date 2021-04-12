class ScrollableTouchBarView: NSCustomTouchBarItem {
    var childViews: [NSView]

    init(identifier: NSTouchBarItem.Identifier, childViews: [NSView]) {
        self.childViews = childViews
        super.init(identifier: identifier)
        self.setupView()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func refreshItems(addedViews: [NSView], removedViews: [NSView]) {
        childViews = childViews.filter { return !removedViews.contains($0) }
        childViews.append(contentsOf: addedViews)
        updateStackView(addedViews: addedViews, removedViews: removedViews)
    }

    private func setupView() {
        view = createBaseStackView(with: childViews)
    }

    private func updateStackView(addedViews: [NSView], removedViews: [NSView]) {
        guard let stackView = self.view as? HorizontalScrollableStackView else { return }
        stackView.removeViews(removedViews)
        stackView.addViews(addedViews)
    }

    private func createBaseStackView(with views: [NSView]) -> HorizontalScrollableStackView {
        let stackView = HorizontalScrollableStackView(views: views)
        return stackView
    }
}
