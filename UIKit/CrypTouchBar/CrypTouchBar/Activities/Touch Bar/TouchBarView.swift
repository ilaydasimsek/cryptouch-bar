class TouchBarView: NSCustomTouchBarItem {

    init(identifier: NSTouchBarItem.Identifier, items: [NSTouchBarItem]) {
        super.init(identifier: identifier)
        let views = items.compactMap { $0.view }
        view = createBaseStackView(with: views)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createBaseStackView(with views: [NSView]) -> NSStackView {
        let stackView = EqualWidthChildStackView(views: views,
                                                 stackViewSize: NSSize(width: 600, height: 30))
        stackView.spacing = 8
        stackView.orientation = .horizontal
        return stackView
    }
}
