import Foundation

public enum SearchSuggestionSection {
    case group(SearchSuggestionGroup)
    case viewMoreResults(title: String)
    case locationPermission(title: String)
}
