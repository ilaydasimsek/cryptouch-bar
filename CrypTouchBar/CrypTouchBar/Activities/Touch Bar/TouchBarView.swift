import SwiftUI

struct TouchBarView: View {
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
        .frame(width: 685, height: 30)
    }
}
