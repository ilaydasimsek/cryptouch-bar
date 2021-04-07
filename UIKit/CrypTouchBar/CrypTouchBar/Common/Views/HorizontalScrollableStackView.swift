import Cocoa

/**
 A horizontal stack view that becomes scrollable if the size of it's children are bigger than it's width
 
 [Inspired by this stackoverflow answer ]( https://stackoverflow.com/questions/10016475/create-nsscrollview-programmatically-in-an-nsview-cocoa/55219153#55219153)
 
 */

class HorizontalScrollableStackView: NSView {
    private let stackView: NSStackView = NSStackView()
    private let scrollView: NSScrollView = NSScrollView()
    private let childViews: [NSView]?

    /**
     Initialized the stack view with given children
     
     - parameter views: The list of children views
     */
    init(views: [NSView]) {
        self.childViews = views
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - View Setup
private extension HorizontalScrollableStackView {
    
    func setupView() {
        setupScrollView()
        setupStackView()
    }

    func setupScrollView() {
        self.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.hasVerticalScroller = true
        scrollView.drawsBackground = false
        scrollView.documentView = stackView

        NSLayoutConstraint.activate([
          scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
          scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
          scrollView.topAnchor.constraint(equalTo: self.topAnchor),
          scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }

    func setupStackView() {
        if let views = self.childViews {
            stackView.setViews(views, in: .leading)
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .horizontal

        // Right anchor is not added so that stack view can grow inside the scroll view
        NSLayoutConstraint.activate([
          stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
          stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
          stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
}
