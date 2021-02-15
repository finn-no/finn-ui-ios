//
//  Copyright © FINN.no AS.
//

// Generated by generate_image_assets_symbols as a "Run Script" Build Phase
// WARNING: This file is autogenerated, do not modify by hand

import UIKit

private class BundleHelper {
}

extension UIImage {
    convenience init(named imageAsset: ImageAsset) {
        #if SWIFT_PACKAGE
        let bundle = Bundle.module
        #else
        let bundle = Bundle(for: BundleHelper.self)
        #endif
        self.init(named: imageAsset.rawValue, in: bundle, compatibleWith: nil)!
    }

    @objc class func assetNamed(_ assetName: String) -> UIImage {
        #if SWIFT_PACKAGE
        let bundle = Bundle.module
        #else
        let bundle = Bundle(for: BundleHelper.self)
        #endif
        return UIImage(named: assetName, in: bundle, compatibleWith: nil)!
    }
}

//swiftlint:disable superfluous_disable_command
//swiftlint:disable type_body_length
enum ImageAsset: String {
    case alphabeticalSortingAscending
    case balloon0
    case balloon1
    case balloon2
    case balloon2Red
    case blinkRocket
    case emptyPersonalNotificationsIcon
    case emptySavedSearchNotificationsIcon
    case favoriteActive
    case favoriteDefault
    case favoritesSortAdStatus
    case favoritesSortDistance
    case favoritesSortLastAdded
    case finnLogoSimple
    case heartMini
    case noImage
    case pin
    case plus
    case profile
    case remove
    case republish
    case schibstedFooter
    case snowflake
    case sort
    case spark
    case splashLetters1
    case splashLetters2
    case splashLetters3
    case splashLetters4
    case splashLogo
    case tagMini
    case trashcan
    case verified
    case videoChat
    case webview

    static var imageNames: [ImageAsset] {
        return [
            .alphabeticalSortingAscending,
            .balloon0,
            .balloon1,
            .balloon2,
            .balloon2Red,
            .blinkRocket,
            .emptyPersonalNotificationsIcon,
            .emptySavedSearchNotificationsIcon,
            .favoriteActive,
            .favoriteDefault,
            .favoritesSortAdStatus,
            .favoritesSortDistance,
            .favoritesSortLastAdded,
            .finnLogoSimple,
            .heartMini,
            .noImage,
            .pin,
            .plus,
            .profile,
            .remove,
            .republish,
            .schibstedFooter,
            .snowflake,
            .sort,
            .spark,
            .splashLetters1,
            .splashLetters2,
            .splashLetters3,
            .splashLetters4,
            .splashLogo,
            .tagMini,
            .trashcan,
            .verified,
            .videoChat,
            .webview,
    ]
  }
}