import UIKit
import FinniversKit

class SearchSuggestionLocationPermissionCell: UITableViewCell {

    // MARK: - Private properties

    private lazy var titleLabel: Label = {
        let label = Label(style: .bodyStrong, withAutoLayout: true)
        label.textColor = .textPrimary
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

        contentView.addSubview(titleLabel)
        titleLabel.fillInSuperview(insets: UIEdgeInsets(top: .spacingS, leading: .spacingM, bottom: -.spacingS, trailing: -.spacingM))
    }

    // MARK: - Configure

    func configure(with title: String) {
        titleLabel.text = title
    }
}
