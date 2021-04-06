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
        let stackView = NSStackView(views: views)
        stackView.spacing = 8
        stackView.orientation = .horizontal

        return stackView
    }
}
