import Foundation

public struct SearchSuggestionGroup {
    public let title: String
    public let items: [SearchSuggestionGroupItem]

    public init(title: String, items: [SearchSuggestionGroupItem]) {
        self.title = title
        self.items = items
    }
}
