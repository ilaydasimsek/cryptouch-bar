import Cocoa

extension NSView {
    func setWidth(toConstant value: CGFloat) {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: value)
        ])
    }
}
