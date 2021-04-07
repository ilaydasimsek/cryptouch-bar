class TouchBarView: NSCustomTouchBarItem {
    let items: [NSTouchBarItem]

    init(identifier: NSTouchBarItem.Identifier, items: [NSTouchBarItem]) {
        self.items = items
        super.init(identifier: identifier)
        self.setupView()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        let views: [NSView] = self.items.compactMap { item in
            guard let view = item.view else { return nil }
            view.setWidth(toConstant: 185)
            return view
        }
        view = createBaseStackView(with: views)
    }

    private func createBaseStackView(with views: [NSView]) -> HorizontalScrollableStackView {
        let stackView = HorizontalScrollableStackView(views: views)
        return stackView
    }
}
