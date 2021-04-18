extension String {
    func firstIndex(of character: String.Element) -> Int? {
        guard let stringIndex: String.Index = self.firstIndex(of: character)
        else { return nil }
        let index: Int = self.distance(from: self.startIndex, to: stringIndex)
        return index
    }
}
