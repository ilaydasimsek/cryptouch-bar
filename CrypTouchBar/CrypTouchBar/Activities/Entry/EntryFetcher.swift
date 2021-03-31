import Foundation

class EntryFetcher {
    func getEntryPage(completion: ((EntryPage) -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            completion?(EntryPage(title: "I'm a crypto app", subtitle: "APP"))
        })
    }
}
