import UIKit
import MapKit

public struct PromotedRealestateCellViewModel {
    public let title: String?
    public let address: String?
    public let primaryAttributes: [String]?
    public let secondaryAttributes: [String]?
    public let totalPriceText: String?
    public let viewingText: String?
    public let primaryImageUrl: String
    public let secondaryImageUrl: String?
    public let realtorName: String?
    public let realtorImageUrl: String?
    public let highlightColor: UIColor?
    public let mapCoordinates: CLLocationCoordinate2D?
    public let zoomLevel: Int?

    public init(
        title: String?,
        address: String?,
        primaryAttributes: [String]?,
        secondaryAttributes: [String]?,
        totalPriceText: String?,
        viewingText: String?,
        primaryImageUrl: String,
        secondaryImageUrl: String?,
        realtorName: String?,
        realtorImageUrl: String?,
        highlightColor: UIColor?,
        mapCoordinates: CLLocationCoordinate2D?,
        zoomLevel: Int?
    ) {
        self.title = title
        self.address = address
        self.primaryAttributes = primaryAttributes
        self.secondaryAttributes = secondaryAttributes
        self.totalPriceText = totalPriceText
        self.viewingText = viewingText
        self.primaryImageUrl = primaryImageUrl
        self.secondaryImageUrl = secondaryImageUrl
        self.realtorName = realtorName
        self.realtorImageUrl = realtorImageUrl
        self.highlightColor = highlightColor
        self.mapCoordinates = mapCoordinates
        self.zoomLevel = zoomLevel
    }
}
