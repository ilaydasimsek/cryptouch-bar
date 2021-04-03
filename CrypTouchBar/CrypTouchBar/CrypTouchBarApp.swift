import SwiftUI

@main
struct CrypTouchBarApp: App {
    var body: some Scene {
        WindowGroup {
            EntryView(viewModel: EntryViewModel())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
