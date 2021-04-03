import SwiftUI

struct EntryView: View {
    @ObservedObject var viewModel: EntryViewModel
    
    var body: some View {
        TouchBarView(coins: viewModel.coins)
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView(viewModel: EntryViewModel())
    }
}
