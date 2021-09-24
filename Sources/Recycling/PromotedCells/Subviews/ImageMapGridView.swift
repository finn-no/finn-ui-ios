import UIKit
import FinniversKit
import MapKit

class ImageMapGridView: UIView {

    // MARK: - Private properties

    private let promoKind: PromotedRealestateCellView.PromoKind
    private let primaryImageUrl: String
    private let secondaryImageUrl: String?
    private let mapCoordinates: CLLocationCoordinate2D?
    private let zoomLevel: Int?
    private weak var remoteImageViewDataSource: RemoteImageViewDataSource?

    private lazy var primaryImageView: RemoteImageView = {
        let view = RemoteImageView(withAutoLayout: true)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(axis: .vertical, spacing: .spacingXS, withAutoLayout: true)
        stackView.addArrangedSubviews([primaryImageView, imageAndMapStackView])
        return stackView
    }()

    private lazy var imageAndMapStackView: UIStackView = {
        let stackView = UIStackView(axis: .horizontal, spacing: .spacingXS, withAutoLayout: true)
        stackView.addArrangedSubviews([mapView, secondaryImageView])
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var secondaryImageView: RemoteImageView = {
        let view = RemoteImageView(withAutoLayout: true)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()

    private lazy var mapView: MKMapView = {
        let view = MKMapView(withAutoLayout: true)
        view.isZoomEnabled = false
        view.isScrollEnabled = false
        view.isUserInteractionEnabled = false
        view.delegate = self
        return view
    }()

    // MARK: - Init

    init(
        promoKind: PromotedRealestateCellView.PromoKind,
        primaryImageUrl: String,
        secondaryImageUrl: String?,
        mapCoordinates: CLLocationCoordinate2D?,
        zoomLevel: Int?,
        remoteImageViewDataSource: RemoteImageViewDataSource?
    ) {
        self.promoKind = promoKind
        self.primaryImageUrl = primaryImageUrl
        self.secondaryImageUrl = secondaryImageUrl
        self.mapCoordinates = mapCoordinates
        self.zoomLevel = zoomLevel
        self.remoteImageViewDataSource = remoteImageViewDataSource
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setup()
    }

    required init?(coder aDecoder: NSCoder) { fatalError() }

    // MARK: - Setup

    private func setup() {
        addSubview(contentStackView)
        contentStackView.fillInSuperview()

        primaryImageView.dataSource = remoteImageViewDataSource
        primaryImageView.loadImage(for: primaryImageUrl, imageWidth: .zero)

        if promoKind == .imagesAndMap, let secondaryImageUrl = secondaryImageUrl, let mapCoordinates = mapCoordinates {
            secondaryImageView.dataSource = remoteImageViewDataSource
            secondaryImageView.loadImage(for: secondaryImageUrl, imageWidth: .zero)

            mapView.addAnnotation(MapPinAnnotation(coordinate: mapCoordinates))

            NSLayoutConstraint.activate([
                primaryImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
                imageAndMapStackView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3)
            ])
        } else {
            imageAndMapStackView.isHidden = true
            primaryImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
        }
    }

    // MARK: - Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()
        guard let mapCoordinates = mapCoordinates else { return }
        if let zoomLevel = zoomLevel {
            mapView.layoutIfNeeded()
            mapView.centerToLocation(coordinates: mapCoordinates, zoomLevel: zoomLevel)
        } else {
            mapView.centerToLocation(coordinates: mapCoordinates)
        }
    }

    // MARK: - Internal methods

    func configure(mapTileOverlay: MKTileOverlay) {
        if let lastOverlay = mapView.overlays.last {
            mapView.removeOverlay(lastOverlay)
        }

        mapView.addOverlay(mapTileOverlay)
    }
}

// MARK: - MKMapViewDelegate

extension ImageMapGridView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }

        let marker = MKAnnotationView(annotation: annotation, reuseIdentifier: "mapPin")
        let markerImage = UIImage(named: .mapPin)
        marker.image = markerImage
        marker.centerOffset = CGPoint(x: 0, y: -(markerImage.size.height / 2))
        return marker
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let overlay = overlay as? MKTileOverlay {
            return MKTileOverlayRenderer(tileOverlay: overlay)
        }

        return MKOverlayRenderer(overlay: overlay)
    }
}

// MARK: - Private extensions / types

private extension MKMapView {
    func centerToLocation(
        coordinates: CLLocationCoordinate2D,
        regionRadius: CLLocationDistance = 250
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: coordinates,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius
        )
        setRegion(coordinateRegion, animated: false)
    }

    func centerToLocation(
        coordinates: CLLocationCoordinate2D,
        zoomLevel: Int
    ) {
        let span = MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 360 / pow(2, Double(zoomLevel)) * Double(frame.size.width) / 256)
        setRegion(MKCoordinateRegion(center: coordinates, span: span), animated: false)
    }
}

private class MapPinAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D

    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
    }
}
