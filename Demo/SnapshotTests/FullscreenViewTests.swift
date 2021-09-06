//
//  Copyright © 2018 FINN AS. All rights reserved.
//

import Demo
import XCTest
import FinniversKit

class FullscreenViewTests: XCTestCase {
    private func snapshot(_ component: FullscreenDemoViews, includeIPad: Bool = false, delay: TimeInterval? = nil, record: Bool = false, testName: String = #function) {
        assertSnapshots(matching: component.viewController, includeDarkMode: true, includeIPad: includeIPad, delay: delay, record: record, testName: testName)
    }

    // MARK: - Tests

    func testMissingSnapshotTests() {
        for element in elementWithoutTests(for: FullscreenDemoViews.self) {
            XCTFail("Not all elements were implemented, missing: \(element.rawValue)")
        }
    }

    func testSnowGlobeView() {
        snapshot(.snowGlobeView)
    }

    func testSplashView() {
        snapshot(.splashView)
    }

    func testNewYearsView() {
        snapshot(.newYearsView)
    }

    func testFavoriteAdSortingView() {
        snapshot(.favoriteAdSortingView)
    }

    func testSearchResultsView() {
        snapshot(.searchResultsView)
    }

    func testSavedSearchSortingView() {
        snapshot(.savedSearchSortingView)
    }

    func testSearchDisplayTypeSelectionView() {
        snapshot(.searchDisplayTypeSelectionView)
    }

    func testSearchDropdown() {
        snapshot(.searchDropdown)
    }

    func testSearchSuggestions() {
        snapshot(.searchSuggestions)
    }

    func testExploreView() {
        snapshot(.exploreView)
    }

    func testExploreDetailView() {
        snapshot(.exploreDetailView)
    }
}
