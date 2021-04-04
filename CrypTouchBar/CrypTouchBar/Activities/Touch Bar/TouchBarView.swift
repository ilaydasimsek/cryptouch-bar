import SwiftUI

struct TouchBarView: View {
    
    struct TouchBarConfig {
        static let touchBarHeight: CGFloat = 30
        static let touchBarWidth: CGFloat = 560
    }

    let itemSymbols: [String]

    var body: some View {
        VStack{
            touchBar
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .focusable()
        .touchBar { touchBar }
    }

    private var touchBar: some View {
        Group {
            HStack {
                ForEach(itemSymbols, id: \.self) { symbol in
                    TouchBarItemView(viewModel: TouchBarItemViewModel(symbol: symbol))
                }
            }
        }
        .frame(width: TouchBarConfig.touchBarWidth, height: TouchBarConfig.touchBarHeight)
    }
}
