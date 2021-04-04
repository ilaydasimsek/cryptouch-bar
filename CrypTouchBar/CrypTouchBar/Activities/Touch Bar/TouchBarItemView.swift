import SwiftUI

struct TouchBarItemView: View {
    @ObservedObject var viewModel: TouchBarItemViewModel

    var body: some View {
        if let coin = viewModel.coin {
            HStack {
                Spacer()
                Text(coin.name)
                    .foregroundColor(Colors.defaultTextColor)
                    .font(.system(size: 12, weight: .heavy, design: .default))
                    .padding(.leading, 4)
                Text(coin.displayPrice)
                    .foregroundColor(viewModel.priceStatus.color)
                    .font(.system(size: 12, weight: .heavy, design: .default))
                    .frame(maxWidth: .infinity)
                Spacer()
            }
            .frame(maxHeight: .infinity)
            .background(Colors.mainBackgroundColor)
            .border(Colors.borderColor, width: 1)
            .cornerRadius(2)
            .padding(3.0)
        }
    }
}
