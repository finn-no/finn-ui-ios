import Foundation
import UIKit
import FinnUI

extension Array where Element == SearchSuggestionSection {
    static func suggestions(withLocationPermission: Bool = false) -> [SearchSuggestionSection] {
        [
            withLocationPermission ? .locationPermission(title: "Vil du se forslag til annonser nærme deg?") : nil,
            .group(.generateSuggestions(title: "Torget", count: 6)),
            .group(.generateSuggestions(title: "Bolig til salgs", count: 2)),
            .group(.generateSuggestions(title: "Alle stillinger", count: 4)),
            .viewMoreResults(title: "Finn flere resultater for 'hund'")
        ].compactMap { $0 }
    }

    static func landingPage(withLocationPermission: Bool = false) -> [SearchSuggestionSection] {
        [
            withLocationPermission ? .locationPermission(title: "Vil du se forslag til annonser nærme deg?") : nil,
            .group(SearchSuggestionGroup(
                title: "Torget",
                items: [
                    SearchSuggestionGroupItem(title: "Torget til salgs", detail: "(6 073 treff)", useBoldPrefix: false),
                    SearchSuggestionGroupItem(title: "Torget gis bort", detail: "(6 treff)", useBoldPrefix: false),
                    SearchSuggestionGroupItem(title: "Torget ønskes kjøpt", detail: "(12 treff)", useBoldPrefix: false)
                ]
            )),
            .group(SearchSuggestionGroup(
                title: "Båt",
                items: [
                    SearchSuggestionGroupItem(title: "Båter til salgs", detail: "(6 073 treff)", useBoldPrefix: false),
                    SearchSuggestionGroupItem(title: "Båtplass tilbys", detail: "(6 treff)", useBoldPrefix: false),
                    SearchSuggestionGroupItem(title: "Båtmotorer til salgs", detail: "(12 treff)", useBoldPrefix: false),
                    SearchSuggestionGroupItem(title: "Båter ønskes kjøpt", detail: "(12 treff)", useBoldPrefix: false),
                    SearchSuggestionGroupItem(title: "Båter til leie", detail: "(12 treff)", useBoldPrefix: false)
                ]
            )),
            .group(SearchSuggestionGroup(
                title: "Bil",
                items: [
                    SearchSuggestionGroupItem(title: "Campingvogner", detail: "(6 073 treff)", useBoldPrefix: false),
                    SearchSuggestionGroupItem(title: "Biler i Norge", detail: "(6 treff)", useBoldPrefix: false),
                    SearchSuggestionGroupItem(title: "Bobiler", detail: "(12 treff)", useBoldPrefix: false),
                    SearchSuggestionGroupItem(title: "Varebiler i Norge", detail: "(12 treff)", useBoldPrefix: false)
                ]
            )),
            .group(SearchSuggestionGroup(
                title: "Eiendom",
                items: [
                    SearchSuggestionGroupItem(title: "Nye boliger", detail: "(6 073 treff)", useBoldPrefix: false),
                    SearchSuggestionGroupItem(title: "Fritidstomter", detail: "(6 treff)", useBoldPrefix: false),
                    SearchSuggestionGroupItem(title: "Bolig til salgs", detail: "(12 treff)", useBoldPrefix: false),
                    SearchSuggestionGroupItem(title: "Bolig ønskes leid", detail: "(12 treff)", useBoldPrefix: false)
                ]
            )),
            .group(SearchSuggestionGroup(
                title: "FINN foreslår",
                items: [
                    SearchSuggestionGroupItem(
                        title: "Leilighet med sjarm og klassisk bad og kjøkken fra 60-tallet. Må ses!",
                        useBoldPrefix: false
                    )
                ]
            ))
        ].compactMap { $0 }
    }
}

// MARK: - Private types / extensions

private enum SuggestionStyle {
    case regular
    case highlighted

    var foregroundColor: UIColor {
        switch self {
        case .regular:
            return .textPrimary
        case .highlighted:
            return .textAction
        }
    }
}

private extension SearchSuggestionGroup {
    static func generateSuggestions(title: String, count: Int) -> SearchSuggestionGroup {
        let reusableItems = [
            SearchSuggestionGroupItem(title: "sykkelvogn", detail: "(325 treff)"),
            SearchSuggestionGroupItem(title: "sykkelstativ", detail: "(972 treff)"),
            SearchSuggestionGroupItem(title: "hundebur", detail: "(972 treff)"),
            SearchSuggestionGroupItem(title: "dører", detail: "(972 treff)", style: .highlighted),
            SearchSuggestionGroupItem(title: "playstation 5", detail: "(810 treff)", style: .highlighted),
            SearchSuggestionGroupItem(title: "veldig veldig veldig lang tekst som sikkert bruker flere linjer. Hvem vet når denne ender?", detail: "(123 treff)")
        ]

        var items = [SearchSuggestionGroupItem]()
        for number in (1 ... count) {
            let item = reusableItems[number % reusableItems.count]
            items.append(item)
        }

        return SearchSuggestionGroup(title: title, items: items)
    }
}

private extension SearchSuggestionGroupItem {
    init(title: String, detail: String? = nil, style: SuggestionStyle = .regular, useBoldPrefix: Bool = true) {
        let sharedAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.body, .foregroundColor: style.foregroundColor]
        let attributedString = NSMutableAttributedString(string: title, attributes: sharedAttributes)

        if useBoldPrefix {
            let boldAttributes = sharedAttributes.mergeOrReplace([.font: UIFont.bodyStrong])
            attributedString.setAttributes(boldAttributes, range: NSRange(location: 0, length: 3))
        }

        self.init(title: attributedString, detail: detail)
    }
}

private extension Dictionary where Key == NSAttributedString.Key, Value == Any {
    func mergeOrReplace(_ otherDictionary: [Key: Value]) -> [Key: Value] {
        merging(otherDictionary, uniquingKeysWith: { this, other in other })
    }
}
