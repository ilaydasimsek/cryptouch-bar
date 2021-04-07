class TouchBarView: NSCustomTouchBarItem {
    let items: [NSTouchBarItem]

    init(identifier: NSTouchBarItem.Identifier, items: [NSTouchBarItem]) {
        self.items = items
        super.init(identifier: identifier)
        let views = items.compactMap { $0.view }
        view = createBaseStackView(with: views)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createBaseStackView(with views: [NSView]) -> NSStackView {
        let stackView = EqualWidthChildStackView(equalWidthViews: views)
        stackView.spacing = 8
        stackView.orientation = .horizontal
        return stackView
    }
}
