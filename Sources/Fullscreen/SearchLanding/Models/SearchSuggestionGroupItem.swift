import Foundation

public struct SearchSuggestionGroupItem {
    public let title: NSAttributedString
    public let detail: String?

    public init(title: NSAttributedString, detail: String?) {
        self.title = title
        self.detail = detail
    }
}
