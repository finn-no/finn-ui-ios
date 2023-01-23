import Foundation

extension SavedSearchesViewModel {
    static let previewData: SavedSearchesViewModel = SavedSearchesViewModel(
        sections: [
            SavedSearchesSection(
                title: "Torget",
                searches: [
                    .init(title: "iPod Classic", text: "På FINN.no, E-post og Push varsling"),
                    .init(title: "Skinnsofa", text: "Kun Push-varsling"),
                    .init(title: "Hipster DBS sykkel", text: "Ingen aktive varsler"),
                    .init(title: "Fender Jaguar", text: "Kun på FINN.no"),
                    .init(title: "OP-1 Syntesizer", text: "På FINN.no, E-post og Push varsling")
                ]
            ),
            SavedSearchesSection(
                title: "Eiendom",
                searches: [
                    .init(title: "Valdresgata", text: "Ingen aktive varslinger"),
                    .init(title: "Bolig til salgs - 'Strandlinje med Jacuzzi', Fra 250 m², Eiendom", text: "På FINN.no, E-post og Push varsling")
                ]
            ),
            SavedSearchesSection(
                title: "Jobb",
                searches: [
                    .init(title: "UX designer - Oslo", text: "Kun på FINN.no")
                ]
            ),
            SavedSearchesSection(
                title: "Bil",
                searches: [
                    .init(title: "Volvo", text: "Ingen aktive varsler"),
                    .init(title: "Lastebil, fra 800 000 kr", text: "Ingen aktive varsler")
                ]
            )
        ]
    )
}
