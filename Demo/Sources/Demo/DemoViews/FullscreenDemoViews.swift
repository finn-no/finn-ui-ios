//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//
import FinniversKit

public enum FullscreenDemoViews: String, DemoViews {
    case searchResultsView
    case snowGlobeView
    case newYearsView
    case splashView
    case savedSearchSortingView
    case searchDisplayTypeSelectionView
    case favoriteAdSortingView
    case searchDropdown
    case searchSuggestions
    case exploreView
    case exploreDetailView

    public var viewController: UIViewController {
        switch self {
        case .searchResultsView:
            return DemoViewController<SearchResultsDemoView>(dismissType: .dismissButton)
        case .snowGlobeView:
            return DemoViewController<SnowGlobeDemoView>()
        case .newYearsView:
            return DemoViewController<NewYearsDemoView>()
        case .splashView:
            return DemoViewController<SplashDemoView>(constrainToTopSafeArea: false, constrainToBottomSafeArea: false)
        case .favoriteAdSortingView:
            return DemoViewController<FavoriteAdSortingDemoView>()
        case .savedSearchSortingView:
            return DemoViewController<SavedSearchSortingDemoView>()
        case .searchDisplayTypeSelectionView:
            return DemoViewController<SearchDisplayTypeSelectionDemoView>()
        case .searchDropdown:
            return DemoViewController<SearchDropdownDemoView>()
        case .searchSuggestions:
            return DemoViewController<SearchSuggestionsDemoView>()
        case .exploreView:
            return makeExploreView()
        case .exploreDetailView:
            return DemoViewController<ExploreDetailDemoView>(constrainToTopSafeArea: true, constrainToBottomSafeArea: false)
        }
    }
}

// MARK: - Private extensions

private extension FullscreenDemoViews {
    func makeExploreView() -> UIViewController {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [
            .font: UIFont.bodyStrong,
            .foregroundColor: UIColor.textPrimary
        ]
        appearance.largeTitleTextAttributes = [
            .font: UIFont(name: UIFont.title1.fontName, size: 28.0)!,
            .foregroundColor: UIColor.textPrimary
        ]

        let viewController = DemoViewController<ExploreDemoView>(constrainToTopSafeArea: false, constrainToBottomSafeArea: false)
        viewController.navigationItem.title = "Torget"
        viewController.navigationItem.largeTitleDisplayMode = .always
        viewController.navigationItem.standardAppearance = appearance
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: .filter),
            style: .plain,
            target: nil,
            action: nil
        )
        let searchController = UISearchController(searchResultsController: nil)
        searchController.showsSearchResultsController = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Søk på Torget"

        viewController.navigationItem.searchController = searchController
        viewController.navigationItem.hidesSearchBarWhenScrolling = false

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
}
