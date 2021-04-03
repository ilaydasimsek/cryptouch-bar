import SwiftUI

struct EntryView: View {
    @ObservedObject var viewModel: EntryViewModel
    
    var body: some View {
        TouchBarView(itemSymbols: viewModel.itemSymbols)
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView(viewModel: EntryViewModel())
    }
}
