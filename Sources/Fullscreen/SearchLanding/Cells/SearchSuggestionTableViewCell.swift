import UIKit
import FinniversKit

class SearchSuggestionTableViewCell: UITableViewCell {

    // MARK: - Private properties

    private lazy var titleLabel: UILabel = {
        let label = UILabel(withAutoLayout: true)
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()

    private lazy var detailLabel: UILabel = {
        let label = UILabel(withAutoLayout: true)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.textColor = .textPrimary
        label.font = .detail
        return label
    }()

    // MARK: - Init

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - Setup

    private func setup() {
        backgroundColor = .bgPrimary
        setDefaultSelectedBackgound()

        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)

        let layoutGuide = UILayoutGuide()
        contentView.addLayoutGuide(layoutGuide)

        NSLayoutConstraint.activate([
            layoutGuide.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .spacingS),
            layoutGuide.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .spacingM),
            layoutGuide.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.spacingM),
            layoutGuide.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.spacingS),

            titleLabel.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),

            detailLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: .spacingXS),
            detailLabel.lastBaselineAnchor.constraint(equalTo: titleLabel.lastBaselineAnchor),
            detailLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor)
        ])
    }

    // MARK: - Configure

    func configure(with item: SearchSuggestionGroupItem) {
        titleLabel.attributedText = item.title
        detailLabel.text = item.detail
    }
}
