import UIKit
import FinniversKit

class SearchSuggestionsSectionHeader: UITableViewHeaderFooterView {

    // MARK: - Pivate properties

    private lazy var pillView = PillView(withAutoLayout: true)

    // MARK: - Init

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setup() {
        contentView.backgroundColor = .bgPrimary
        contentView.addSubview(pillView)

        NSLayoutConstraint.activate([
            pillView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .spacingS),
            pillView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .spacingM),
            pillView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -.spacingM),
            pillView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.spacingS)
        ])
    }

    // MARK: - Configure

    func configure(with title: String) {
        pillView.configure(with: title)
    }
}

// MARK: - Private class

private class PillView: UIView {

    private lazy var titleLabel = Label(style: .captionStrong, withAutoLayout: true)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        setContentHuggingPriority(.required, for: .horizontal)
        backgroundColor = .bgTertiary
        titleLabel.textColor = .textSecondary
        addSubview(titleLabel)
        titleLabel.fillInSuperview(insets: UIEdgeInsets(top: .spacingXS, leading: .spacingS, bottom: -.spacingXS, trailing: -.spacingS))
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
    }

    func configure(with title: String) {
        titleLabel.text = title
    }
}
