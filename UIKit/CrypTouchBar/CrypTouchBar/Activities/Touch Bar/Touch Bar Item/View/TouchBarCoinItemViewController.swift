import Cocoa

class TouchBarCoinItemController: NSViewController {
    
    override var nibName: NSNib.Name? {
        return "TouchBarCoinItemView"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        prepareView()
    }
}

private extension TouchBarCoinItemController {
    
    func prepareView() {
        self.view.wantsLayer = true
        self.view.layer?.cornerRadius = 8
        self.view.layer?.borderWidth = 2
        self.view.layer?.borderColor = NSColor.systemPink.cgColor
    }
}
