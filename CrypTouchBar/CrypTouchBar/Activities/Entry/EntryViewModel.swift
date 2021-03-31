import SwiftUI

class EntryPage {
    let title: String
    let subtitle: String

    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
}

class EntryViewModel: ObservableObject {

    @Published var title = ""
    @Published var subtitle = ""

    private let fetcher = EntryFetcher()

    init() {
       startFetch()
    }

    private func startFetch() {
        fetcher.getEntryPage(completion: { [weak self] entryPage in
            guard let self = self else { return }
            self.title = entryPage.title
            self.subtitle = entryPage.subtitle
        })
    }
}
