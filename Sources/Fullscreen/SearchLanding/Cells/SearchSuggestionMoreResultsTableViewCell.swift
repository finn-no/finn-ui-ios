import UIKit
import FinniversKit

class SearchSuggestionMoreResultsTableViewCell: UITableViewCell {

    // MARK: - Private properties

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(axis: .horizontal, spacing: .spacingM, withAutoLayout: true)
        stackView.addArrangedSubviews([iconImageView, titleLabel])
        stackView.alignment = .center
        return stackView
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(withAutoLayout: true)
        imageView.image = UIImage(named: .searchBig)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .textPrimary
        return imageView
    }()

    private lazy var titleLabel: Label = {
        let label = Label(style: .bodyStrong, withAutoLayout: true)
        label.textColor = .textAction
        label.numberOfLines = 0
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

        contentView.addSubview(stackView)
        stackView.fillInSuperview(insets: UIEdgeInsets(top: .spacingS, leading: .spacingM, bottom: -.spacingS, trailing: -.spacingM))

        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 28),
            iconImageView.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    // MARK: - Configure

    func configure(with title: String) {
        titleLabel.text = title
    }
}
