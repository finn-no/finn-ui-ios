import FinnUI
import FinniversKit

class SearchSuggestionsDemoView: UIView, Tweakable {

    lazy var tweakingOptions: [TweakingOption] = [
        TweakingOption(title: "Search suggestions", description: "With location permission cell") { [weak self] in
            self?.searchSuggestionsView.configure(with: .suggestions(withLocationPermission: true))
        },
        TweakingOption(title: "Search suggestions", description: "Without location permission cell") { [weak self] in
            self?.searchSuggestionsView.configure(with: .suggestions())
        },
        TweakingOption(title: "Search landingpage", description: "With location permission cell") { [weak self] in
            self?.searchSuggestionsView.configure(with: .landingPage(withLocationPermission: true))
        },
        TweakingOption(title: "Search landingpage", description: "Without location permission cell") { [weak self] in
            self?.searchSuggestionsView.configure(with: .landingPage())
        }
    ]

    private lazy var searchSuggestionsView: SearchSuggestionsView = {
        let view = SearchSuggestionsView(withAutoLayout: true)
        view.delegate = self
        return view
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        tweakingOptions.first?.action?()
    }

    required init?(coder aDecoder: NSCoder) { fatalError() }

    // MARK: - Setup

    private func setup() {
        addSubview(searchSuggestionsView)
        searchSuggestionsView.fillInSuperview()
    }
}

// MARK: - SearchSuggestionsViewDelegate

extension SearchSuggestionsDemoView: SearchSuggestionsViewDelegate {
    func searchSuggestionsView(_ view: SearchSuggestionsView, didSelectResultAt indexPath: IndexPath) {
        print("🔥🔥🔥🔥 indexPath = \(indexPath)")
        print("🔥🔥🔥🔥 \(#function)")
    }

    func searchSuggestionsViewDidSelectViewMoreResults(_ view: SearchSuggestionsView) {
        print("🔥🔥🔥🔥 \(#function)")
    }

    func searchSuggestionsViewDidSelectLocationButton(_ view: SearchSuggestionsView) {
        print("🔥🔥🔥🔥 \(#function)")
    }

    func searchSuggestionsViewDidScroll() {
        print("🔥🔥🔥🔥 \(#function)")
    }
}
