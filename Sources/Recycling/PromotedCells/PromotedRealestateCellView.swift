import UIKit
import FinniversKit
import MapKit


public protocol PromotedRealestateCellViewDelegate: AnyObject {
    func promotedRealestateCellViewDidToggleFavoriteState(_ view: PromotedRealestateCellView)
}

public class PromotedRealestateCellView: UIView {

    public enum PromoKind {
        case singleImage // Plus
        case imagesAndMap // Premium
    }

    // MARK: - Public properties

    public weak var delegate: PromotedRealestateCellViewDelegate?

    public var isFavorited: Bool {
        primaryFavoriteButton.isFavorited
    }

    // MARK: - Private properties

    private let viewModel: PromotedRealestateCellViewModel
    private let promoKind: PromoKind
    private weak var remoteImageViewDataSource: RemoteImageViewDataSource?

    private lazy var primaryFavoriteButton = createFavoriteButton()
    private lazy var secondaryFavoriteButton = createFavoriteButton(includeShadow: true)
    private lazy var viewingInfoView = ViewingInfoView(withAutoLayout: true)
    private lazy var highlightView = UIView(withAutoLayout: true)

    private lazy var imageMapGridView = ImageMapGridView(
        promoKind: promoKind,
        primaryImageUrl: viewModel.primaryImageUrl,
        secondaryImageUrl: viewModel.secondaryImageUrl,
        mapCoordinates: viewModel.mapCoordinates,
        remoteImageViewDataSource: remoteImageViewDataSource
    )

    private lazy var realtorInfoView = RealtorInfoView(
        realtorName: viewModel.realtorName,
        realtorLogoUrl: viewModel.realtorImageUrl,
        remoteImageViewDataSource: remoteImageViewDataSource
    )

    private lazy var titleLabel: Label = {
        let label = Label(style: .body, withAutoLayout: true)
        label.numberOfLines = 0
        return label
    }()

    private lazy var addressLabel: Label = {
        let label = Label(style: .caption, withAutoLayout: true)
        label.numberOfLines = 0
        label.textColor = .textSecondary
        return label
    }()

    private lazy var primaryAttributesLabel: Label = {
        let label = Label(style: .bodyStrong, withAutoLayout: true)
        label.numberOfLines = 0
        return label
    }()

    private lazy var secondaryAttributesLabel: Label = {
        let label = Label(style: .caption, withAutoLayout: true)
        label.numberOfLines = 0
        label.textColor = .textSecondary
        return label
    }()

    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(axis: .vertical, spacing: .zero, withAutoLayout: true)
        stackView.addArrangedSubviews([titleLabel, addressLabel, primaryAttributesLabel, secondaryAttributesLabel])
        stackView.setCustomSpacing(.spacingXS, after: titleLabel)
        stackView.setCustomSpacing(.spacingM, after: addressLabel)
        stackView.setCustomSpacing(.spacingS, after: primaryAttributesLabel)
        return stackView
    }()

    private lazy var realtorAndFavoriteStackView: UIStackView = {
        let stackView = UIStackView(axis: .horizontal, spacing: .spacingS, withAutoLayout: true)
        stackView.addArrangedSubviews([realtorInfoView, primaryFavoriteButton])
        stackView.alignment = .center
        return stackView
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(axis: .vertical, spacing: .spacingS, withAutoLayout: true)
        stackView.addArrangedSubviews([
            imageMapGridView,
            highlightView,
            realtorAndFavoriteStackView,
            textStackView,
            viewingInfoView
        ])
        stackView.setCustomSpacing(0, after: imageMapGridView)
        stackView.alignment = .leading
        return stackView
    }()

    // MARK: - Init

    public init(
        viewModel: PromotedRealestateCellViewModel,
        promoKind: PromoKind,
        remoteImageViewDataSource: RemoteImageViewDataSource?,
        withAutoLayout: Bool
    ) {
        self.viewModel = viewModel
        self.promoKind = promoKind
        self.remoteImageViewDataSource = remoteImageViewDataSource
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = !withAutoLayout
        setup()
    }

    required init?(coder aDecoder: NSCoder) { fatalError() }

    // MARK: - Setup

    private func setup() {
        titleLabel.text = viewModel.title
        addressLabel.text = viewModel.address
        primaryAttributesLabel.text = viewModel.primaryAttributes.joined(separator: " • ")
        secondaryAttributesLabel.text = viewModel.secondaryAttributes.joined(separator: "・")
        highlightView.backgroundColor = viewModel.highlightColor

        addSubview(contentStackView)
        contentStackView.fillInSuperview()

        NSLayoutConstraint.activate([
            highlightView.heightAnchor.constraint(equalToConstant: .spacingS),
            imageMapGridView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            realtorAndFavoriteStackView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            textStackView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor)
        ])

        if let viewingText = viewModel.viewingText {
            viewingInfoView.configure(with: viewingText)
        } else {
            viewingInfoView.isHidden = true
        }

        if promoKind == .imagesAndMap {
            addSubview(secondaryFavoriteButton)
            NSLayoutConstraint.activate([
                secondaryFavoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: .spacingM),
                secondaryFavoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.spacingM)
            ])
        }

        configure(isFavorited: isFavorited)
    }

    // MARK: - Public methods

    public func configure(mapTileOverlay: MKTileOverlay) {
        imageMapGridView.configure(mapTileOverlay: mapTileOverlay)
    }

    public func configure(isFavorited: Bool) {
        primaryFavoriteButton.configure(isFavorited: isFavorited)
        secondaryFavoriteButton.configure(isFavorited: isFavorited)

        if isFavorited {
            primaryFavoriteButton.tintColor = .textAction
            secondaryFavoriteButton.tintColor = .white
        } else {
            primaryFavoriteButton.tintColor = .textSecondary
            secondaryFavoriteButton.tintColor = .white
        }
    }

    // MARK: - Private methods

    private func createFavoriteButton(includeShadow: Bool = false) -> FavoriteButton {
        let button = FavoriteButton(withAutoLayout: true)
        button.delegate = self

        if includeShadow {
            button.configureShadow()
        }

        return button
    }
}

// MARK: - FavoriteButtonDelegate

extension PromotedRealestateCellView: FavoriteButtonDelegate {
    func favoriteButtonDidToggleFavoriteState(_ button: FavoriteButton) {
        delegate?.promotedRealestateCellViewDidToggleFavoriteState(self)
    }
}
