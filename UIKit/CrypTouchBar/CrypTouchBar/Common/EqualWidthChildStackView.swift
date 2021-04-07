import Cocoa

class EqualWidthChildStackView: NSStackView {

    convenience init(views: [NSView], stackViewSize: NSSize) {
        self.init(views: views)
        self.setEqualWidthConstraints(for: views)
        self.setViewConstraints(size: stackViewSize)
    }
    
    private func setEqualWidthConstraints(for views: [NSView]) {
        guard let firstView = views.first else { return }
        let contraints: [NSLayoutConstraint] = views.compactMap { view in
            guard view != firstView else { return nil }
            return NSLayoutConstraint(item: view,
                               attribute: NSLayoutConstraint.Attribute.width,
                               relatedBy: NSLayoutConstraint.Relation.equal,
                               toItem: firstView, attribute: NSLayoutConstraint.Attribute.width,
                               multiplier: 1,
                               constant: 0)
        }
        NSLayoutConstraint.activate(contraints)
    }

    private func setViewConstraints(size: NSSize) {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: size.width),
            self.heightAnchor.constraint(equalToConstant: size.height)
        ])
    }
}
