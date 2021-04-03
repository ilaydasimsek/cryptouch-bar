import SwiftUI

struct TouchBarItemView: View {
    @ObservedObject var viewModel: TouchBarItemViewModel

    var body: some View {
        if let coin = viewModel.coin {
            HStack {
                Spacer()
                Text(coin.name)
                Text(coin.displayPrice)
                Spacer()
            }
            .padding([.top, .bottom], 3)
            .border(Color("BackgroundColor"), width: 1)
            .cornerRadius(2)
            .padding(3.0)
        }
    }
}
