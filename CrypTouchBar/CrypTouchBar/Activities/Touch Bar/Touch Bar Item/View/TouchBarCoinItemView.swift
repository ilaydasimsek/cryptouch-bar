import Cocoa

class TouchBarCoinItemView: NSView {
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var priceLabel: NSTextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.prepareView()
    }

    func update(nameLabelText: String, priceLabelText: String, priceLabelColor: NSColor) {
        priceLabel.stringValue = priceLabelText
        nameLabel.stringValue = nameLabelText
        priceLabel.textColor = priceLabelColor
        self.isHidden = false
    }

    private func prepareView() {
        self.isHidden = true
        self.setupLayer()
        nameLabel.font = NSFont.systemFont(ofSize: 13.5, weight: .semibold)
        nameLabel.textColor = Colors.defaultTextColor
        priceLabel.textColor = Colors.defaultTextColor
        nameLabel.stringValue = ""
        priceLabel.stringValue = ""
    }

    private func setupLayer() {
        self.wantsLayer = true
        self.layer?.cornerRadius = 8
        self.layer?.borderWidth = 2
        self.layer?.borderColor = Colors.borderColor.cgColor
        self.layer?.backgroundColor = Colors.mainBackgroundColor.cgColor
        self.setWidth(toConstant: 190)
        self.setHeight(toConstant: 30)
    }
}
